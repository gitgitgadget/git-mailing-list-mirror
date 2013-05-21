From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8 0/3] Begin replacing OpenSSL with CommonCrypto
Date: Tue, 21 May 2013 21:19:12 +0200
Message-ID: <519BC8B0.5050100@web.de>
References: <1368959016-23146-1-git-send-email-sunshine@sunshineco.com> <7vfvxhs1pz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>,
	=?windows-1252?Q?Torsten_B=F6gershau?= =?windows-1252?Q?sen?= 
	<tboegi@web.de>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 21:19:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ues5h-00018m-OP
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 21:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab3EUTTR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 15:19:17 -0400
Received: from mout.web.de ([212.227.17.11]:55936 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068Ab3EUTTR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 15:19:17 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LmuMO-1U035h0NDQ-00hg4U; Tue, 21 May 2013 21:19:13
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vfvxhs1pz.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:rBCEzQpXKdwrchPZK87MsNNsF6j9n0YLfgo7yxcM3V2
 deXXj7lSwEaxeHQw9hynY1LxcPGAfN+5k0+7525wsriz0qkuvN
 Jos+9qdku2YwswxQjFGmgb3+NzeWjltf0vT2PNUioicAV+R4bV
 bnDHKf0k7naqXKRRrl96yXI3sxRvl6E1o42CYbDrs9XaCTt5Yv
 /1CwJ8QhywmtbdPz9fMwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225066>

On 2013-05-21 00.52, Junio C Hamano wrote:
> Thanks, will replace da/darwin with this round.
(May be late response, not sure if this is the right email thread.
I eventually managed to compile under 10.6, what we have on pu)

One minor nit, or 2:
imap-send.c: In function =91cram=92:
imap-send.c:913: warning: statement with no effect

This fixes it:

diff --git a/imap-send.c b/imap-send.c
index 8ea180f..11577c9 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -35,7 +35,7 @@ typedef void *SSL;
#define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, len=
)
#define HMAC_Update CCHmacUpdate
#define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
-#define HMAC_CTX_cleanup
+#define HMAC_CTX_cleanup(c)
#define EVP_md5() kCCHmacAlgMD5
#else
#include <openssl/evp.h>


(And I think there are more minor nits:
#define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
could be written as
#define HMAC_Final(hmac, hash, ptr) CCHmacFinal((hmac), (hash))
(Use paranthese around each parameter)
Similar change for HMAC_Init()

/Torsten
