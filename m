From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t9401 fails with OS X sed
Date: Thu, 25 Oct 2012 14:51:23 +0200
Message-ID: <508935CB.9020408@web.de>
References: <609AC6E7-45CD-4472-B1DC-FBB785D6B815@gernhardtsoftware.com> <F721B376-F4E6-4274-9A6E-BD1CFCBDA39F@adacore.com> <20121025084132.GB8390@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Geert Bosch <bosch@adacore.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 14:51:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRMuZ-0001u1-Qu
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 14:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759415Ab2JYMvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 08:51:36 -0400
Received: from mout.web.de ([212.227.15.3]:53262 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803Ab2JYMvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 08:51:35 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0Lw1CH-1TLkd43tLZ-018H6x; Thu, 25 Oct 2012 14:51:24 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121025084132.GB8390@sigill.intra.peff.net>
X-Provags-ID: V02:K0:2Peihbmlp108BkTrc4T8KikkiPztrQetLM3KRKm49WQ
 7RzukcjAizQyXGbKDKdCGD5rmE6N1px3jUxusPhUF5DLSNofqM
 iuqkyPDjc6fb68W3bF40w8Wnv6v5DuIv0zmX3jEDrYDmqhq4FL
 g9fwFqeapbyOaCKlD3U9NqxSOnfTuQm+MW/GOOrokumGwbhDDK
 l8oMHj1n/ntC9s19xQyRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208397>

On 25.10.12 10:41, Jeff King wrote:
> On Thu, Oct 25, 2012 at 01:04:11AM -0400, Geert Bosch wrote:
> 
>> On Oct 24, 2012, at 23:54, Brian Gernhardt <brian@gernhardtsoftware.com> wrote:
>>
>>> It works if I change \s to [[:space:]], but I don't know how portable that is.
>>
>> As \s is shorthand for the POSIX character class [:space:], I'd say the latter
>> should be more portable: anything accepting the shorthand should also accept
>> the full character class. If not, you probably only care about horizontal tab
>> and space, for which you could just use a simple regular expression. Just a
>> literal space and tab character between square brackets is probably going to be
>> most portable, though not most readable.
> 
> I agree that the POSIX character class would be more portable than "\s",
> but we do not have any existing uses of them, and I would worry a little
> about older systems like Solaris. If we can simply use a literal space
> and tab, that seems like the safest.
> 
> Brian, can you work up a patch?
> 
> -Peff

Would this be portable:
(It works on my Mac OS X box after installing cvs)
But I don't have solaris


diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index cdb8360..f2ec9d2 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -46,7 +46,7 @@ check_status_options() {
        echo "Error from cvs status: $1 $2" >> "${WORKDIR}/marked.log"
        return 1;
     fi
-    got="$(sed -n -e 's/^\s*Sticky Options:\s*//p' "${WORKDIR}/status.out")"
+    got="$(tr '\t' ' ' < "${WORKDIR}/status.out" | sed -n -e 's/^ *Sticky Options: *//p')"
     expect="$3"
     if [ x"$expect" = x"" ] ; then
        expect="(none)"
