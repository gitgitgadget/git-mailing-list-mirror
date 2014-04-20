From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-remote-hg : Enable use of,
 $GIT_DIR/hg/origin/clone/.hg/hgrc
Date: Sun, 20 Apr 2014 13:12:05 -0500
Message-ID: <53540df5ad0fb_18fb153d2ec8b@nysa.notmuch>
References: <53076DFC.1000602@gmail.com>
 <53499bb02c140_285f9032ec58@nysa.notmuch>
 <CANNJ_zjVaymTUmSSFHfSpmcH7H2v62nsHaUoxRfi098zqLi_Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Delcypher <delcypher@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 20:30:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbwVs-00033r-Tu
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 20:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbaDTSap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 14:30:45 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:39161 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276AbaDTSao (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 14:30:44 -0400
Received: by mail-yh0-f50.google.com with SMTP id t59so999344yho.37
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=/aS1Z5Hdti6ZGbRfRGSORnn4RrWWtPsTk4aaSWXzo90=;
        b=SW94EbZdJTK7NH8SwdVIlvAgo3UUmuxLi29NXZhwyCqbJk1xhhNSD/1XVYjZeyGliQ
         730xDK1b6nuATCM3sHFP4Hgwdwg6U+hi6XPZVMTkzgWRMnXheV4HUgbrQxHPZC2CUUtw
         LOTyWyWpPKcfIacDWytQ6BTxt5flv0nBR7Pr81BYiNMCCxXk/SzDmtK+U3K+M3iu76CM
         OX2oRPeF4SQo4pnwygXpMNwOHMOxOZXGCCn6xsIC5Qhet3pFjnG4s89/nHXyd5M/2UJK
         r73JxjuCWzIW579B89LXS+Nxw9sMjgkLSPChC3qSLBSBjgPgX7PGj3NfFtSSHBGGwz6G
         nbVA==
X-Received: by 10.236.131.42 with SMTP id l30mr95182yhi.130.1398018145648;
        Sun, 20 Apr 2014 11:22:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id p68sm65239235yho.10.2014.04.20.11.22.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 11:22:24 -0700 (PDT)
In-Reply-To: <CANNJ_zjVaymTUmSSFHfSpmcH7H2v62nsHaUoxRfi098zqLi_Ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246555>

Delcypher wrote:
> > What is the problem you are trying to solve?
> The problem I was trying to solve is I wanted my authentication
> details to be in a hgrc local to the repository.
> 
> The problem is git-remote-hg will parse
> ``.git/hg/origin/clone/.hg/hgrc`` but will ignore any settings in it
> (this seems a little silly).
> You can see that git-remote-hg parses this by placing invalid syntax
> in the file.
> 
> > Is there a way to test that this
> > code is working correctly?
> 
> The effects are much more obvious if you use a mercurial repository
> that uses https and then you try to push to it with authentication
> details in ``.git/hg/origin/clone/.hg/hgrc``. For example
> 
> [auth]
> cc.prefix = hg.codeplex.com
> cc.username = USERNAME
> cc.password = PASSWORD
> cc.schemes = https
> 
> pushing will fail because the authorisation details get completely
> ignored and you will get an exception raised with a stack trace like
> this...
> 
> Traceback (most recent call last):
>   File "/home/dsl11/dev/git-remote-hg/git-remote-hg", line 1254, in <module>
>     sys.exit(main(sys.argv))
>   File "/home/dsl11/dev/git-remote-hg/git-remote-hg", line 1238, in main
>     do_export(parser)
>   File "/home/dsl11/dev/git-remote-hg/git-remote-hg", line 1119, in do_export
>     if not push(parser.repo, peer, parsed_refs, p_revs):
>   File "/home/dsl11/dev/git-remote-hg/git-remote-hg", line 1007, in push
>     ret = push_unsafe(repo, remote, parsed_refs, p_revs)
>   File "/home/dsl11/dev/git-remote-hg/git-remote-hg", line 990, in push_unsafe
>     return remote.unbundle(cg, remoteheads, 'push')
>   File "/usr/lib/python2.7/site-packages/mercurial/wireproto.py", line
> 308, in unbundle
>     ret, output = self._callpush("unbundle", cg, heads=heads)
>   File "/usr/lib/python2.7/site-packages/mercurial/httppeer.py", line
> 201, in _callpush
>     r = self._call(cmd, data=fp, headers=headers, **args)
>   File "/usr/lib/python2.7/site-packages/mercurial/httppeer.py", line
> 171, in _call
>     fp = self._callstream(cmd, **args)
>   File "/usr/lib/python2.7/site-packages/mercurial/httppeer.py", line
> 118, in _callstream
>     resp = self.urlopener.open(req)
>   File "/usr/lib/python2.7/urllib2.py", line 410, in open
>     response = meth(req, response)
>   File "/usr/lib/python2.7/urllib2.py", line 523, in http_response
>     'http', request, response, code, msg, hdrs)
>   File "/usr/lib/python2.7/urllib2.py", line 442, in error
>     result = self._call_chain(*args)
>   File "/usr/lib/python2.7/urllib2.py", line 382, in _call_chain
>     result = func(*args)
>   File "/usr/lib/python2.7/urllib2.py", line 897, in http_error_401
>     url, req, headers)
>   File "/usr/lib/python2.7/site-packages/mercurial/url.py", line 436,
> in http_error_auth_reqed
>     self, auth_header, host, req, headers)
>   File "/usr/lib/python2.7/urllib2.py", line 872, in http_error_auth_reqed
>     response = self.retry_http_basic_auth(host, req, realm)
>   File "/usr/lib/python2.7/urllib2.py", line 878, in retry_http_basic_auth
>     user, pw = self.passwd.find_user_password(realm, host)
>   File "/usr/lib/python2.7/site-packages/mercurial/url.py", line 36,
> in find_user_password
>     raise util.Abort(_('http authorization required'))
> mercurial.error.Abort: http authorization required
> 
> 
> However, if you don't have a repository to hand you could also do the
> following to observe the settings in the repository's hgrc being
> respected
> 
> 1. Clone a repository
> $ git clone hg::https://hg.codeplex.com/boogie
> 
> 2. Add setting to ``.git/hg/origin/clone/.hg/hgrc``
> 
> [ui]
> quiet = True
> 
> 3. With the current of git-remote-hg, when you do a pull you see
> 
> $ git pull
> searching for changes
> no changes found
> Already up-to-date.
> 
> You can see that "quiet" is **not** being respected. If use my patch
> to git-remote-hg and run again you see
> 
> 
> $ git pull
> Already up-to-date.
> 
> which shows "quiet" being respected.

This is what I get:

% git pull                                                                                                          /tmp/boogie[master] nysa
searching for changes
no changes found
Already up-to-date.
 % cat > .git/hg/origin/clone/.hg/hgrc <<EOF
[ui]
quiet = True
EOF
 % git pull                                                                                                          /tmp/boogie[master] nysa
Already up-to-date.

So clearly there is something different on my side.

What version of Mercurial are you using?

-- 
Felipe Contreras
