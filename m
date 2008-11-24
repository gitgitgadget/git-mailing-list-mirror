From: Andriy Gapon <avg@icyb.net.ua>
Subject: Re: git-svn and svnsync
Date: Mon, 24 Nov 2008 19:33:43 +0200
Message-ID: <492AE577.30308@icyb.net.ua>
References: <48F6F631.90709@icyb.net.ua> <492AA464.5070404@icyb.net.ua> <492AE13D.5070102@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070901020208010709070007"
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 18:35:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4fKz-0005G8-71
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 18:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbYKXRdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 12:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbYKXRdt
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 12:33:49 -0500
Received: from citadel.icyb.net.ua ([212.40.38.140]:2719 "EHLO
	citadel.icyb.net.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbYKXRdt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 12:33:49 -0500
Received: from odyssey.starpoint.kiev.ua (alpha-e.starpoint.kiev.ua [212.40.38.101])
	by citadel.icyb.net.ua (8.8.8p3/ICyb-2.3exp) with ESMTP id TAA19138;
	Mon, 24 Nov 2008 19:33:43 +0200 (EET)
	(envelope-from avg@icyb.net.ua)
User-Agent: Thunderbird 2.0.0.17 (X11/20081106)
In-Reply-To: <492AE13D.5070102@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101619>

This is a multi-part message in MIME format.
--------------070901020208010709070007
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

on 24/11/2008 19:15 Michael J Gruber said the following:
> Andriy Gapon venit, vidit, dixit 24.11.2008 13:56:
>> on 16/10/2008 11:07 Andriy Gapon said the following:
>>> I did the following:
>>> 1. mirror svn repository using svnsync
>>> 2. clone the mirror with git-svn --use-svnsync-props and some tweaking[*]
>>> 3. run git svn info in the clone
>>> 4. get error "Unable to determine upstream SVN information from working
>>> tree history"
>>>
>>> git svn log and git svn rebase do not work either.
>>> git log does work.
>>>
>>> I have git version 1.6.0.2 (from FreeBSD ports).
>>> [*] About the tweaking - I manually massaged config file to get the
>>> branches I was interested in, so .git/config is this:
>>> [core]
>>>         repositoryformatversion = 0
>>>         filemode = true
>>>         bare = false
>>>         logallrefupdates = true
>>> [svn-remote "svn"]
>>>         useSvnsyncProps = 1
>>>         url = file:///system/devel/svn/base
>>>         fetch = head:refs/remotes/trunk
>>>         fetch = stable/6:refs/remotes/stable_6
>>>         fetch = stable/7:refs/remotes/stable_7
>>>         fetch = releng/6.3:refs/remotes/releng_6_3
>>>         fetch = releng/6.4:refs/remotes/releng_6_4
>>>         fetch = releng/7.0:refs/remotes/releng_7_0
>>>         fetch = release/6.3.0:refs/remotes/release_6_3_0
>>>         fetch = release/7.0.0:refs/remotes/release_7_0_0
>>>
>>> This is .git/svn/.metadata:
>>> ; This file is used internally by git-svn
>>> ; You should not have to edit it
>>> [svn-remote "svn"]
>>>         reposRoot = file:///system/devel/svn/base
>>>         uuid = ccf9f872-aa2e-dd11-9fc8-001c23d0bc1f
>>>         svnsync-uuid = ccf9f872-aa2e-dd11-9fc8-001c23d0bc1f
>>>         svnsync-url = svn://svn.freebsd.org/base
>>>
>>> So you can see the original svn repository URL.
>>>
>>> git log reports svn info like the following:
>>> git-svn-id: svn://svn.freebsd.org/base/stable/7@183898
>>> ccf9f872-aa2e-dd11-9fc8-001c23d0bc1f
>>>
>>> It seems that the problem is that the code in find_by_url() and/or
>>> read_all_remotes() subroutines (in git-svn.perl) are not aware of
>>> svnsync and do not realize an URL in logs and URL in svn-remote are
>>> different.
>>> BTW, I see that there is some special svm logic in read_all_remotes.
>>>
>>> Thank you very much for any help in advance.
>>>
>> Anyone?
>> I wonder if this is my local problem/misconfiguration or an issue with
>> git-svn.
> 
> Same happens here, so it's a general issue ;)
> 
> I think I encountered that before and ended up experimenting with
> git-svn cloning from a svnsync source until I found the final config,
> with which I git-svn cloned directly from upstream, so that I had to
> wait only twice.

I hacked together an ugly patch that replaces svm support with snvsync
support. This works for me, not sure if it will be useful in general.


-- 
Andriy Gapon

--------------070901020208010709070007
Content-Type: text/plain;
 name="git-svn.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="git-svn.patch"

LS0tIGdpdC1zdm4JMjAwOC0xMS0xMSAxMDoyMDozOC43MTQ2MjA0NDIgKzAyMDAKKysrIGdp
dC1zdm4JMjAwOC0xMS0wNyAxNzoxMDo0OS4yNDU2ODEyMTMgKzAyMDAKQEAgLTE0MzMsNyAr
MTQzMyw3IEBACiBzdWIgcmVhZF9hbGxfcmVtb3RlcyB7CiAJbXkgJHIgPSB7fTsKIAlteSAk
dXNlX3N2bV9wcm9wcyA9IGV2YWwgeyBjb21tYW5kX29uZWxpbmUocXcvY29uZmlnIC0tYm9v
bAotCSAgICBzdm4udXNlU3ZtUHJvcHMvKSB9OworCSAgICBzdm4udXNlU3Zuc3luY1Byb3Bz
LykgfTsKIAkkdXNlX3N2bV9wcm9wcyA9ICR1c2Vfc3ZtX3Byb3BzIGVxICd0cnVlJyBpZiAk
dXNlX3N2bV9wcm9wczsKIAlmb3JlYWNoIChncmVwIHsgcy9ec3ZuLXJlbW90ZVwuLy8gfSBj
b21tYW5kKHF3L2NvbmZpZyAtbC8pKSB7CiAJCWlmIChtIV4oLispXC5mZXRjaD1ccyooLiop
XHMqOlxzKiguKylccyokISkgewpAQCAtMTQ0NSw3ICsxNDQ1LDcgQEAKIAkJCSRsb2NhbF9y
ZWYgPX4gc3teL317fTsKIAkJCSRyLT57JHJlbW90ZX0tPntmZXRjaH0tPnskbG9jYWxfcmVm
fSA9ICRyZW1vdGVfcmVmOwogCQkJJHItPnskcmVtb3RlfS0+e3N2bX0gPSB7fSBpZiAkdXNl
X3N2bV9wcm9wczsKLQkJfSBlbHNpZiAobSFeKC4rKVwudXNlc3ZtcHJvcHM9XHMqKC4qKVxz
KiQhKSB7CisJCX0gZWxzaWYgKG0hXiguKylcLnVzZXN2bnN5bmNwcm9wcz1ccyooLiopXHMq
JCEpIHsKIAkJCSRyLT57JDF9LT57c3ZtfSA9IHt9OwogCQl9IGVsc2lmIChtIV4oLispXC51
cmw9XHMqKC4qKVxzKiQhKSB7CiAJCQkkci0+eyQxfS0+e3VybH0gPSAkMjsKQEAgLTE0NzEs
OSArMTQ3MSw4IEBACiAJCQkJbXkgJHNlY3Rpb24gPSAic3ZuLXJlbW90ZS4kXyI7CiAJCQkJ
JHN2bSA9IHsKIAkJCQkJc291cmNlID0+IHRtcF9jb25maWcoJy0tZ2V0JywKLQkJCQkJICAg
ICIkc2VjdGlvbi5zdm0tc291cmNlIiksCi0JCQkJCXJlcGxhY2UgPT4gdG1wX2NvbmZpZygn
LS1nZXQnLAotCQkJCQkgICAgIiRzZWN0aW9uLnN2bS1yZXBsYWNlIiksCisJCQkJCSAgICAi
JHNlY3Rpb24uc3Zuc3luYy11cmwiKSwKKwkJCQkJcmVwbGFjZSA9PiAnJywKIAkJCQl9CiAJ
CQl9OwogCQkJJHItPnskX30tPntzdm19ID0gJHN2bTsK
--------------070901020208010709070007--
