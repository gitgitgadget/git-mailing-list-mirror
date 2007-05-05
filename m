From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Fri, 4 May 2007 23:46:46 -0700
Message-ID: <56b7f5510705042346s759a2ef9tfa3a223fe7af7c16@mail.gmail.com>
References: <463BD40C.6080909@gmail.com>
	 <Pine.LNX.4.64.0705050324580.4015@racer.site>
	 <7vwszolz26.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 05 08:47:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkE2l-0006wM-Kw
	for gcvg-git@gmane.org; Sat, 05 May 2007 08:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbXEEGqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 02:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbXEEGqs
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 02:46:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:59792 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbXEEGqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 02:46:47 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1115404wra
        for <git@vger.kernel.org>; Fri, 04 May 2007 23:46:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NKkA/vgABGcG81pgD2ikT6APRzwe0e/48sKq6bVGzZKONghRfctMOastRIe5YBFGoY2e+bGXbqf3iVuYAt9qUuokbSodqNAtm7uTTN6NY6pujOA7vxiTdnJZaLF5zelXfSfC1URBU8yzwfKZujKwy0v2Jiy+MOoJJpwIKyv7gH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZR+vce13Guj4CrAQppI+4RR7hwBluhJ21gcLaTRvh185uPLLg6jdNxGk10872Cw+ZOfC6HneRzdo4GgtqhcajxV9ecpYwHuX+FiI/BYGW2NSZJJVvQSd/Jd3xofQmhUBSpDB0JBfvSyUO2Vfz2swLTRKQRvDHZjIiKjHPfT++L8=
Received: by 10.114.145.1 with SMTP id s1mr1431344wad.1178347606111;
        Fri, 04 May 2007 23:46:46 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Fri, 4 May 2007 23:46:46 -0700 (PDT)
In-Reply-To: <7vwszolz26.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46246>

Thanks for your reply.  I can wait for 1.5.2.
So I will _quickly_ address some other points JS and SP mentioned.

(a) In a bare repository, I believe setup.c:setup_git_directory_gently()
determines the prefix to be NULL.  This means my patch will see
ALL paths as absolute,  except :../path which will result in an error.

(b) For :path and :stage:path , relative is useful for me.

(c) For <commit-ish>:path ,  again relative is useful for me.
All my examples were of this form.

(d) Where <tree-ish> in <tree-ish>:path is just a tree and no
commit is involved, relative paths make no sense since you don't
know where the tree is. (Imagine it moved between commits.)
So don't call my prepend_prefix() or call it with prefix faked to NULL.

Unfortunately I was never clear about (a) and my patch fails
to discriminate between (c) and (d).  I'll try to fix the latter later.

Thanks

Dana

On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Think of the "todo" branch, for example. And this is not even far fetched.
> > In many repositories I have to have separate related, but non-branch
> > HEADs. For example, I track some projects with custom scripts. These
> > scripts do _not_ belong into that branch. However, they are related, so I
> > store them in the same repository.
>
> I said I won't talk about it until 1.5.2 final, but you forced
> me into it.
>
> > Plus, my example of the bare-repository still has not been answered by
> > _anyone_ in favour of changing the current behaviour.
>
> I am not sure if there is anything to answer on this one.
>
> When you are talking to a bare-repository, your place relative
> to the root of the working tree is clearly undefined, and it is
> natural that "<tree-ish>:./<path>", "<tree-ish>:/<path>" and
> "<tree-ish>:<path>" cannot mean anything but relative to the
> root of the tree-ish.  "<tree-ish>:../<path>" is obviously
> nonsense.  So it does not matter if unadorned <path> is relative
> to cwd or root in this case.
>
> Your other example, however, gives a much better illustration.
> An unrelated 'todo' branch where your cwd does not have any
> relevance to the contents of that tree-ish, or worse yet, a
> commit from git-gui project in git.git repository, where taking
> your cwd into account has an actively wrong effect, demonstrates
> why we would need a way to say "By this path, I mean from the
> top, I do not want you to take it as relative to where I am".
>
> One way to ensure that is to keep the current "it is a path from
> the top" behaviour, and extended it with "... unless it begins
> with ./".  Doing this forever however penalizes the case where
> you want to use relative paths by requiring ./ at the beginning.
>
> Another is to do the usual POSIXy path interpretation and
> "unless it begins with /, it is taken as relative to where you
> are".  This penalizes the 'todo' and git-gui commit use case
> because the user explicitly needs to say "where I am does not
> matter" by prefixing the path with '/', and also necessitates a
> change to the syntax for looking backwards for a commit with
> that message, because the existing syntax to look for a string
> clashes with it [*1*].
>
> Both have merits and demerits.  If we did not have any existing
> code and users, the latter is clearly what we would have done,
> as it is more consistent.  The path handling feels more natural
> (in line with the way we expect paths to be handled on POSIX
> systems), the "look backwards" search feels more natural ( you
> use '/' for forward search, '?' for backwards).
>
> I also suspect the latter is more often convenient.  When
> working on a flat project, it does not matter if the default is
> relative to cwd or to the root.  But if your project is deep,
> and if you somehow do "git show" more often than "git diff" (I
> don't, but different people may do so for different reasons), it
> would start to hurt if you always have to say "./".
>
> It is however clearly a bigger change to existing users.
> Correcting earlier mistakes is painful, so it certainly is
> tempting to take the approach that the path is always absolute
> and require "./" for relative.  I agree it is an easier change,
> but I am not convinced yet that it is the right design in the
> longer term.
>
> [Footnote]
>
> *1* This is only true for looking for a path in the index case,
> as <commit>:/<string> does not seem to work.  I think this is a
> bug in the current code -- shouldn't it limit the search to
> commits that are reachable from that named one?

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
