From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv12 00/23] git notes
Date: Thu, 28 Jan 2010 02:17:29 +0100
Message-ID: <201001280217.29459.johan@herland.net>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
 <201001280005.03190.johan@herland.net>
 <7vk4v3nlji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 02:17:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaJ0s-0007GU-77
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 02:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab0A1BRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 20:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754659Ab0A1BRc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 20:17:32 -0500
Received: from smtp.getmail.no ([84.208.15.66]:60321 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754636Ab0A1BRb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 20:17:31 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWX0058XNL6NGC0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Jan 2010 02:17:30 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWX00AZ5NL5DV00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Jan 2010 02:17:30 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.28.10323
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <7vk4v3nlji.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138215>

On Thursday 28 January 2010, Junio C Hamano wrote:
> The earlier frustration of mine was about adding a note, not adding _to_
>  a note.  The semantic difference I described with add/edit was "adding
>  anew" vs "modify".
> 
> Once I realize that Dscho's original "edit" lacks an explicit "adding
> anew" and it simply means "replace if exists otherwise add", then I can
> agree the argument that "adding anew" mode is not necessary.
> 
> The semantic difference your add/edit try to capture works at a different
> level.  They are "append to it" vs "replace it".  Current "edit -m 'foo'"
> that replaces feels to me quite counterintuitive.
> 
> If two modes are useful, then I would suggest to deprecate the use of
> "edit" subcommand with -m/-F (because its name doesn't tell the user
>  which one between "append" and "replace" it happens to implement) and
>  instead introduce two more explicit subcommands, "append" and "replace".
>   For the same reason, "add" would cause confusion between "is this to
>  add a new note" vs "is this to add _to_ a new note", and I'd recommend
>  against it.
> 
> "edit" could still open an editor to "modify" existing one (and if there
> is no existing one, then the editor starts empty).
> 
> On the other hand, if "replace" is not very useful, then it might be
> enough to just introduce a new "append" subcommand.  Or course, we could
> redefine the useless "replace" semantics from "edit -m/-F" and change it
> to always append.

Ok, I see your point, and I largely agree with your analysis. I'll attempt 
to summarize what we want from "git notes" in this regard:

- git notes add: Add a new note. Open editor for giving the note contents.
  Barf if a note already exists for the given object.

	Options:
	-m <msg>, --message <msg>: Specify note contents on command-line instead
		of opening editor. (Multiple -m options are concatenated.)

	-F <file>, --file <file>: Get note contents from the given file instead
		of opening editor.

	-f, --force: Instead of barfing, replace/overwrite existing notes.

- git notes append: Append to an existing note; create new note if needed.
  Open editor for giving the (additional) note contents.

	Options:
	-m <msg>, --message <msg>: (Same as above)
	-F <file>, --file <file>: (Same as above)

- git notes edit: Edit an existing note. Create new note if needed (?)
  Open editor for editing the existing note contents.

	No options (deprecate existing -m and -F options)

Is this what you had in mind? AFAICS it should cover all interesting use 
cases.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
