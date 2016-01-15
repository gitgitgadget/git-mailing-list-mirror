From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/4] mingw: squash another warning about a cast
Date: Fri, 15 Jan 2016 14:24:39 +0100 (CET)
Message-ID: <8075ca3dff83486406b05b1701d025727ab86da9.1452864241.git.johannes.schindelin@gmx.de>
References: <cover.1452864241.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 14:25:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK4N8-0003l0-VY
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 14:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161092AbcAONYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 08:24:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:58746 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161062AbcAONYx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 08:24:53 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LvVUR-1aBqtH04zD-010g9p; Fri, 15 Jan 2016 14:24:40
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452864241.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:7S+hhkTgJkwU8CpfDB3obo2azQFPxFdMV/pL+FcL5GpFrGdTQAN
 Y95Ie48COtxjSUpclnr3i6+5tk851lgMcD5BNRIIKAzNbZ4FnXhaDZ5uZ5CmTeeJ4VXYDbr
 2TouqqBMkrtxDSjmCL5yW2vgDw5ET0ICRvAfEFM1IMfUcVxN+VkAvxnDFEV1QAxY+9PsXWD
 AMFs5gRt2Qqcoc2jYZiVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fjh9+UIVRHg=:+UShZ5ipOcYIrmXTg5Yg2L
 2rF8lLpcuLbGkTDPFsevRdAMkOCcn6EmgbbtS0m0rY+AALfUEhviMvQT5GIL0uVw9Y90lnOqb
 R9jZOBrDu+th+pSre8VZEg9+ruDDhuh8Z2wzlD/mHTtauZwqWvER5QeKWVh3SaO1oq9D9LfTP
 ux26wf0BON9J/nW2S2iObyScNBL7Zp/x58IPPu4B5/U277rA3OgrXha0cVRozcxOk2dgShV3w
 5YfBKV+T5CAV9+jB2IaYIjWvyT0nhpiwWwPz9y+cVygRj0m+qJw8We5+3L3V0hxoxAGTRGS6q
 47/zUUeREK5VElUwmx5pCn5EINE10jaAbyg3FZgcq1KtzJv2HZHmkM0OHjpf+RsOjO+CgtQqV
 Nwq/0N6CPN5XFLqVVmQU50+WDtZEv+mYC2NezUOiEZO5ibpM+elTKT531bzrt+ndZKg6biHDL
 aezTS67n9nObrNpRJiigNSQUqm1y221Xn6M/VGg3/VRYJNhDanJIGp0JiSFctQhXPul2uuGH9
 zVWrv3rFBttlTT0yGIn3w+STmUPgmsNn2j0B8T0msBKKE7EZMoZxN5ewHnRGhkTirXS9m3CfP
 zoJ0Cs1jZOzl7tjJnzwI4cZ8wETCqJJbWL+Z5k9HZGIvha4UQ1LIjN3PdxdpXrzjMLpqindoA
 Y8IJ1ySh0Np5TJDCG24+9cPTelJi8Scu5EvhblNK0H/JY3H4ooTHQ9XEnF/JuV2zgNuOChEfH
 kUXW0YIoHsrayA7lajh6eiEFFPbeYLlgiJw41egDTo5S+2WVSAcnRjQLOEKc9gOL93NhUZH7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284169>

MSys2's compiler is correct that casting a "void *" to a "DWORD" loses
precision, but in the case of pthread_exit() we know that the value
fits into a DWORD.

Just like casting handles to DWORDs, let's work around this issue by
casting to "intrptr_t" first, and immediately cast to the final type.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/pthread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 8ad1873..d3dd872 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -77,7 +77,7 @@ extern pthread_t pthread_self(void);
 
 static inline int pthread_exit(void *ret)
 {
-	ExitThread((DWORD)ret);
+	ExitThread((DWORD)(intptr_t)ret);
 }
 
 typedef DWORD pthread_key_t;
-- 
2.7.0.windows.1.7.g55a05c8
