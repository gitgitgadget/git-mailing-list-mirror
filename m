From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Sat, 15 Mar 2014 13:28:39 +0100
Message-ID: <53244777.2040302@web.de>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>	<1394477377-10994-4-git-send-email-benoit.pierre@gmail.com> <xmqqk3c0o3cj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 13:29:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOniY-0008Hk-7M
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 13:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984AbaCOM26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 08:28:58 -0400
Received: from mout.web.de ([212.227.17.11]:62086 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbaCOM25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 08:28:57 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MhUfW-1WlIMc26U6-00Mdh5; Sat, 15 Mar 2014 13:28:40
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqk3c0o3cj.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:FqFz/WtHjfdemX4lUMmh4za/LMKLbebhsV9erNKlUzeugeQF8IM
 qWaS+zul7kQ1pgpN6JO8z9/Q190MT0x8Qd/M/33xZ+V+ap3qr009xx4bPshyrvngcnFvHYa
 kQvx71ROtGHMxSVi/j9JLDlpqZX7a1ZHEal8UxV1Zcd1K65gri2ohznoQhxJHvhHImBdFjo
 PmijPxtoGJzNIAg9WEPRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244152>

On 2014-03-11 22.03, Junio C Hamano wrote:
> Benoit Pierre <benoit.pierre@gmail.com> writes:
> 
>> Add (failing) test: with commit changing the environment to let hooks
>> now that no editor will be used (by setting GIT_EDITOR to ":"), the
>> "edit hunk" functionality does not work (no editor is launched and the
>> whole hunk is committed).
>>
>> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
>> ---
>>  t/t7513-commit_-p_-m_hunk_edit.sh | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>  create mode 100755 t/t7513-commit_-p_-m_hunk_edit.sh
>>
>> diff --git a/t/t7513-commit_-p_-m_hunk_edit.sh b/t/t7513-commit_-p_-m_hunk_edit.sh
> 
> I'll move this to t/t7514-commit-patch.sh for now while queuing.

This line is problematic:
	echo e | env GIT_EDITOR="sed s/+line3\$/+line2/ -i" git commit -p -m commit2 f

(sed -i is not portable:
http://pubs.opengroup.org/onlinepubs/007908799/xcu/sed.html)

The whole test hangs in a forever loop loop under MacOS:
debug=t verbose=t ./t7514-commit-patch.sh 
Stage this hunk [y,n,q,a,d,/,e,?]? @@ -1 +1,2 @@
 line1
+line3

I think perl can be used instead of sed (but I haven't found the exact syntax yet)
