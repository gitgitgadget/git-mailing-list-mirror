From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 01/18] (trivial) notes.h: Minor documentation fixes to copy_notes()
Date: Tue, 5 Oct 2010 17:22:20 +0200
Message-ID: <201010051722.21081.johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net> <1285719811-10871-2-git-send-email-johan@herland.net> <20101005145543.GD12797@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 17:22:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P39LT-0008DO-RH
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 17:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab0JEPWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 11:22:14 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:61600 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab0JEPWN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 11:22:13 -0400
Received: from dslb-088-073-123-190.pools.arcor-ip.net ([88.73.123.190] helo=epsilon.localnet)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P39LG-000Ntg-KV; Tue, 05 Oct 2010 17:22:10 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <20101005145543.GD12797@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158202>

On Tuesday 5. October 2010 16.55.43 Jonathan Nieder wrote:
> Johan Herland wrote:
> > --- a/notes.h
> > +++ b/notes.h
> > @@ -104,6 +104,10 @@ const unsigned char *get_note(struct notes_tree *t,
> > 
> >   * Copy a note from one object to another in the given notes_tree.
> >   *
> >   * Fails if the to_obj already has a note unless 'force' is true.
> > 
> > + *
> > + * IMPORTANT: The changes made by copy_note() to the given notes_tree structure
> > + * are not persistent until a subsequent call to write_notes_tree() returns
> > + * zero.
> 
> This reminds me: I sometimes wish there were a
> Documentation/technical/api-notes.txt giving a high-level overview of
> the API,

I thought studying the notes.h file and its comments was a sufficient
introduction on how to work with notes in code. I'm certainly biased,
though (as I obviously already know how to work with notes in code)...

If you believe that api-notes.txt is a valuable addition to
Documentation/, I have no problem ack-ing a patch that adds it.

> something like this to start (warning: formatting probably broken):
> 
> -- 8< --
> notes API
> =========
> 
> So you want to write or access persistent, per-object text?  The notes
> API might help.
> 
> Calling sequence
> ----------------
> 
> The caller:
> 
> * Allocates and clears a `struct notes_tree`, then fills it based on a
>   new or existing notes ref with `init_notes()`.
> 
> * Adds, removes, and retrieves notes as desired:
> 
>   . To add notes: use `write_sha1_file()` to create a blob object
>     containing the information to be stored, and add it to the
>     in-core notes tree with `add_note()`.
> 
>   . Retrieve notes as blob objects with `get_note()`, or as
>     text with `format_note()`.
> 
>   . Change which objects a note is attached to with `copy_note()`
>     and `remove_note()`.
> 
> * Can iterate over all notes with `for_each_note()`.
> 
> * Can remove notes attached to missing objects with `prune_notes()`.
> 
> * (Optionally) makes changes persist with `write_notes_tree()`.
> 
> * Frees resources associated to the notes tree with `free_notes()`.
> 
> A program like 'git log' that needs to find the notes corresponding
> to certain objects in multiple notes trees might instead use the
> display notes API.  In this case, the caller:
> 
> * (Optionally) prepares a `struct display_notes_opt` with settings
>   about which notes trees to use.
> 
> * Initializes the display notes machinery with `init_display_notes()`.
> 
> * Retrieves notes for each object of interest with
>   `format_display_notes()`.
> -- >8 --

This looks like a good start.


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
