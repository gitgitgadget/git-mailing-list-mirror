From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 13:00:47 -0700
Message-ID: <xmqqlhgtftw0.fsf@gitster.dls.corp.google.com>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	<1431384645-17276-4-git-send-email-dturner@twopensource.com>
	<xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
	<1431455779.16652.20.camel@ubuntu>
	<xmqqk2wdzlfm.fsf@gitster.dls.corp.google.com>
	<1431456922.16652.26.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 12 22:00:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsGMI-0003VI-As
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 22:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbbELUAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 16:00:50 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36821 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812AbbELUAt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 16:00:49 -0400
Received: by iepk2 with SMTP id k2so10851152iep.3
        for <git@vger.kernel.org>; Tue, 12 May 2015 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NeOGbL3iPRB7kMFPxFbQlV/U6lecuIWHn8PJfs/SEws=;
        b=I/YlCGrhqOUfD2lUkD1qRCtRPNcTFppMV04pbCklYMHci7CZqWyT/HRe7ZqboSkCiu
         VTmeHlXpX2CjtbdGCFYM8/4ygYSe0zrw3Ibf5PE1oNZZryYxW2/3X78Z6clKulFG6FZ6
         sGBWy/tKnYOv0gMz//9AslYlVTHAqunpCzdjwNWlibcgeR1XireRhfYfWVVtkb9PHiUO
         pgw/5MeRLvg1cxvrlXB2nFB6iC+cSXWFMOw2a4UrOYYM4sm0gIWDXtInWfziUz1yk/hy
         toMAFP9n9Q0RqnFoOWJYLPnAqXl5baalZVDOgWXLOftwmaEty1betsQsrNXitKO/YN+Q
         RIUQ==
X-Received: by 10.50.66.230 with SMTP id i6mr6076177igt.22.1431460848553;
        Tue, 12 May 2015 13:00:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id kl1sm1894185igb.15.2015.05.12.13.00.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 13:00:47 -0700 (PDT)
In-Reply-To: <1431456922.16652.26.camel@ubuntu> (David Turner's message of
	"Tue, 12 May 2015 14:55:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268877>

David Turner <dturner@twopensource.com> writes:

> On Tue, 2015-05-12 at 11:43 -0700, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>> 
>> >> We need to also say something about the "missing" vs "loop" case, if
>> >> we choose to leave that part broken.  I'd rather see it fixed, but
>> >> that is not a very strong preference.
>> >
>> > Will add an example.
>> 
>> I do not think we need an example.  By "also say", I meant in
>> addition to "This and that does not currently work", we also need to
>> say that loops do not work well.  In other words, it is enough to
>> just mention that it is a current limitation (or a bug, whichever we
>> choose to call) that loops are reported as missing.
>
> The version of the patch that we are commenting on contained the text: 
>> +     --batch-check.  In the event of a symlink loop (or more than
>> +     40 symlinks in a symlink resolution chain), the file will be
>> +     treated as missing.  If a symlink points outside the tree-ish
>
> Is that sufficient?  

Not really, as I think people would say "treated as missing" is a
bug, and it would be better to mark it as "currently does not work"
in the sense that "you cannot use this feature to tell HEAD:link
that is not in HEAD and HEAD:link that is a symbolic link that
points to itself apart".

> Actually, we could simply have a separate output for broken links.
> Instead of [original path] SP missing, [original path] SP loop.

Hmm, I do not quite see where this resistance against keeping the
original request in order to say "You gave HEAD:link to me, but that
is a symbolic link that leads to 'link'" comes from.  After all,
wouldn't that be more consistent with what you already show for a
link that cannot be resolved, i.e. "You gave HEAD:link to me, that
is a link that points at 'nosuch'" when I do this:

    $ ln -s nosuch link
    $ git add link
    $ echo "$(git write-tree):link" |
      git cat-file --batch --follow-symlinks

Ahh, that would also give us "missing", so in that sense you are
being consistent.

But I do not think that consistency is useful.  Showing just
"missing" instead is losing information and that is what bothers me.

Showing "symlink 6 nosuch" to this "link points at a target that
would be in-tree but there is no such object in the tree" symbolic
link instead of "missing" would make it more useful, and I do not
offhand think of a downside, but maybe I am missing something.

For a link that points outside, the code already gives

    $ ln -s ../outside outlink
    $ git add outlink
    $ echo "$(git write-tree):outlink" |
      git cat-file --batch --follow-symlinks

"symlink ../outside", so the script reading from the batch output
already has to be prepared to handle "symlink" and understand it as
saying "the link does not point an object that is inside the tree".
