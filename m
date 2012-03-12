From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Re*: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Mon, 12 Mar 2012 21:58:10 +0100
Message-ID: <4F5E6362.7050001@web.de>
References: <201203052039.16893.tboegi@web.de> <7vzkbuzss7.fsf@alter.siamese.dyndns.org> <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com> <7vfwdkm6xs.fsf@alter.siamese.dyndns.org> <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com> <7v4nu0m5tb.fsf@alter.siamese.dyndns.org> <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com> <7vd38okmp0.fsf@alter.siamese.dyndns.org> <7vlin94dbc.fsf_-_@alter.siamese.dyndns.org> <4F5BD585.5050007@web.de> <4F5CC08C.90703@web.de> <7vzkbnvt6m.fsf@alter.siamese.dyndns.org> <4F5D14CD.6080507@web.de> <7vzkbmvmvx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:58:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7CK0-0001Lw-DH
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 21:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295Ab2CLU6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 16:58:19 -0400
Received: from smtp-out11.han.skanova.net ([195.67.226.200]:43149 "EHLO
	smtp-out11.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756872Ab2CLU6S (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 16:58:18 -0400
Received: from birne.lan (194.22.188.61) by smtp-out11.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4F5CB98E000925F8; Mon, 12 Mar 2012 21:58:10 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vzkbmvmvx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192944>

[snip]
 (. gettext.sh; eval_gettext frotz; echo $?)
frotz0

> What is curious about your system is that git-sh-i18n.sh should have
> figured out that you want INTERNAL_GETTEXT_SH_SCHEME to be gnu by
> itself, without any need for "make USE_GETTEXT_SCHEME=gnu", with
> these lines:
> 
>                 ...
>         elif type gettext.sh >/dev/null 2>&1
>         then
>                 # GNU libintl's gettext.sh
>                 GIT_INTERNAL_GETTEXT_SH_SCHEME=gnu
>         elif test ...
> 
> as long as you have /sw/bin/gettext.sh on your PATH, that is.
> 
> So I am not sure what's broken.
=====================
When I run the following scriptlet, 
extracted from git-sh-i18n
=====================
#!/bin/sh
GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
if test -n ""
then
	GIT_INTERNAL_GETTEXT_SH_SCHEME=""
elif test -n "@@USE_FALLTHROUGH_GETTEXT_SCHEME@@$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
then
		echo ": no probing necessary"
elif test -n "$GIT_GETTEXT_POISON"
then
	echo GIT_INTERNAL_GETTEXT_SH_SCHEME=poison
elif type gettext.sh >/dev/null 2>&1
then
	# GNU libintl's gettext.sh
	echo GIT_INTERNAL_GETTEXT_SH_SCHEME=gnu
elif test "$(gettext -h 2>&1)" = "-h"
then
	# gettext binary exists but no gettext.sh. likely to be a gettext
	# binary on a Solaris or something that is not GNU libintl and
	# lack eval_gettext.
	echo GIT_INTERNAL_GETTEXT_SH_SCHEME=gettext_without_eval_gettext
fi
======================
I get
: no probing necessary
=====================

The generated git-sh-i18n is identical under both Ubuntu and Mac OS X.
(Except that Mac OS uses /Users instead of /home)

And may be the diff between git-sh-i18n.sh and the generated git-sh-i18n can give a hint:

 diff git-sh-i18n.sh git-sh-i18n
13c13
<       TEXTDOMAINDIR="@@LOCALEDIR@@"
---
>       TEXTDOMAINDIR="/Users/tb/share/locale"
21c21
< if test -n "@@USE_GETTEXT_SCHEME@@"
---
> if test -n ""
23c23
<       GIT_INTERNAL_GETTEXT_SH_SCHEME="@@USE_GETTEXT_SCHEME@@"
---
>       GIT_INTERNAL_GETTEXT_SH_SCHEME=""
