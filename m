From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/10] Better "Changed but not updated" message in
 git-status
Date: Thu, 28 Oct 2010 17:09:56 -0500
Message-ID: <20101028220956.GC16125@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288290117-6734-2-git-send-email-Matthieu.Moy@imag.fr>
 <20101028183513.GC14212@burratino>
 <7vaaly9eji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 00:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBag3-0002ao-Jj
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 00:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933212Ab0J1WKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 18:10:05 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42677 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760380Ab0J1WKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 18:10:03 -0400
Received: by yxk8 with SMTP id 8so1306100yxk.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 15:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pJnkPgkn1w3Kxl4TQbFnOcj2JefoQOzilcVHaHmpC3s=;
        b=iMLsPQyZktC057QZ2m74vXy9EKkNBup6M3DVGhr2Nq7wBrzweOZUisZx9+nPqd3luo
         ymLwYcsjrvRzi9GBrLg69Uo80KIScsnIId9dWCRBrTRK/y/rPpl7GXutMtdFb8EFeOl3
         OI1EhCRntVyMEDrfeESUkfbH7MhG6kIgvJu+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oOHGPEHT1QoY+qdw3VcTpXgV853HCezYKw/hBrhEO0H4G3Z17ZWOX5mMRMezOdq4rp
         hE6BtKh7cmmxlKD/QeqKcRZMdjB5BYmTtiMqNKpypmiBgvETWKjkUVuENcTzka975THp
         pXbJyvuHnk3Q0wvG8uFQdjMzDUJSU4dNBfU3k=
Received: by 10.150.190.3 with SMTP id n3mr1657499ybf.282.1288303802127;
        Thu, 28 Oct 2010 15:10:02 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v9sm6198527ybe.9.2010.10.28.15.10.00
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 15:10:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaaly9eji.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160240>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  # Changes to be committed:
>>  #   (use "git reset HEAD <file>..." to unstage)
>>  #
>>  #       new file:   foo.c
>>  #
>>  # Changes not staged for commit:
[...]
> Hmm, perhaps we'd want to restate the first one as well to read
> 
>     Changes staged for commit:
>       (use "git reset HEAD <path>..." to unstage)
> 
> for consistency as well?

My first impression is no.  Since the main purpose of this text is to
be shown by "git commit", it might even make sense to say:

# Changes to be committed:
#   (use "git reset -- <path>..." to unstage)
#
#	new file:    foo.c
#
# Changes not to be committed:
#   (use "git add <path>..." to update what will be committed)
#   (use "git checkout -- <path>..." to discard changes in working
#   directory)
#
#	typechange:  bar.c

> Listing by filename gives a false impression that we are talking about the
> whole file contents, and looks a bit confusing until it is explained to
> you why when the same file appears in both of the first two sections.

Iould be nice if the "staged changes" section gave a hint that there
were unstaged changes present.  Maybe something like the
"unsaved file" indicator used by some text editors:

	new file:    foo.c*

> I've been wondering ever since this thread started if we can phrase it
> better to make it even less confusing.  E.g.
> 
>     Files with changes to be committed:
>         new file: foo.c
>     Files with changes that won't be committed:
>         modified: foo.c
> 
> might help reduce the confusion.

I fear that it can be misparsed as (Files with changes) to be committed.
More importantly, I think Matthieu was right earlier: it is not the
files but the changes that matter.

So when changing a file and marking it executable, I would even like to
see:

	modified:    foo.c
	mode change: foo.c

even if that is not what git does today.
