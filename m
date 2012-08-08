From: David Aguilar <davvid@gmail.com>
Subject: Re: Sync production with Git
Date: Wed, 8 Aug 2012 15:35:53 -0700
Message-ID: <CAJDDKr5=zDEn4j9HAp3k5ubOJ1g5J-VhAka=BpoNuJbJ+ES_og@mail.gmail.com>
References: <1344431484059-7564617.post@n2.nabble.com>
	<vpqlihpbh4f.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	sitaramc@gmail.com
To: kiranpyati <kiran.pyati@infobeans.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:36:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzErB-0003IK-ND
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 00:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757151Ab2HHWfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 18:35:55 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55896 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756640Ab2HHWfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 18:35:54 -0400
Received: by vbbff1 with SMTP id ff1so1283302vbb.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 15:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=L3jKddsrzobfgQdMAhW+0i0dvdUS8HWPpcdCTSSN94I=;
        b=h4ojZqa4kUugFltJIVc6u+djxMfli8MCFXdk4OlGoqZlO+851BcEKPCiY3ktyBdYuY
         l3VYBZi5lSWseZU7bGXjScWLxl5y1aYygqp0f0/rxgI0sdGirCdPT8i3QPDKFCVFspr3
         xl0F/d0ykJmEw3xSvHO/DBCtSyMhviU+agdcdUiYW/1AF2i0eN5eisTP95H4StxbrNvT
         TniSLCLv9ocQ5+l7/4HZ968xhEYvhRjHzYGzyWeHq0ZK1W0MstoRDdg93hKpNMFGqapE
         6y19cxnTXJmci+ebIh2uOGTZt7P+V18G+7G6pzGDa3VDcpvjIVk0ohgmKZNvOOMPXrGH
         TdEQ==
Received: by 10.52.99.138 with SMTP id eq10mr13267519vdb.25.1344465353813;
 Wed, 08 Aug 2012 15:35:53 -0700 (PDT)
Received: by 10.59.9.36 with HTTP; Wed, 8 Aug 2012 15:35:53 -0700 (PDT)
In-Reply-To: <vpqlihpbh4f.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203139>

On Wed, Aug 8, 2012 at 7:20 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> kiranpyati <kiran.pyati@infobeans.com> writes:
>
>> We want a way to seamlessly sync production and Git.
>
> You should be aware that Git was not designed for this scenario. The
> usual flow with Git (and actually with most revision control systems),
> is to do the development with Git, then use your build system to
> generate a package that can be used in production (e.g. generate a
> .tar.gz, or a .jar, or whatever your platform needs), and then install
> this package on your production server.


Obligatory link to Sitaram's very helpful docs:

http://sitaramc.github.com/the-list-and-irc/deploy.html

Thanks to Sitaram for this very helpful guide.


That said, please pay close attention to everything Matthieu wrote
here.  It seems like things will go smoothly once you "true things up"
and then follow a sensible process for moving things from git to
production going forward.  Sitaram's write-up can help you discover
what the right process is for you.


> It can be tempting, however, to use your revision control system as a
> deployment tool, so that an update on the production server be as simple
> as "git pull". But in real-life applications, it usually has to be more
> complicated: do you need to generate some files after you fetch the
> latest version of the source? Do you need to update your database? Isn't
> the .git/ directory harmfull here (e.g. do I want the full history
> source of my project to be visible worldwide if this is a
> webapplication?) ...
>
> If you insist in using Git for deployment, then you should absolutely
> stick to it. Whether for deployment or for anything else, trying to send
> changes using both Git and other mechanism (e.g. uploading files
> directly to a working tree as you did) puts you in trouble 99.9% of the
> cases.
>
> In your case, the damage is already done. If I were you, I'd do
> something like
>
> <do some backup>
> <make sure the backup is OK>
> <think twice "will I be able to restore the backup if it goes wrong?">
> $ git fetch origin
> $ git reset --hard origin/master
>
> (actually, if I were you, I'd try reproducing the situation on a
> non-production server first)
>
> "git fetch" will download the revisions from the remote server, which
> should be the repository where the version you want to run is located.
> "git reset --hard" will discard any local change (committed or not) you
> may have, and set your local working tree to the latest version in the
> master branch of the remote repository. You may need a "git clean" to
> remove untracked files too.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
David
