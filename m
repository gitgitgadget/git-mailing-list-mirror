From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v14 03/13] utf8: add function to align a string into given
 strbuf
Date: Sat, 29 Aug 2015 19:10:16 +0200
Message-ID: <55E1E778.4030400@web.de>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 19:10:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVjeB-0007uT-EJ
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 19:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbbH2RK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 13:10:26 -0400
Received: from mout.web.de ([212.227.17.12]:53817 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792AbbH2RKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 13:10:25 -0400
Received: from birne.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MejmG-1ZKh063GPY-00OKcZ; Sat, 29 Aug 2015 19:10:18
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <1440857537-13968-4-git-send-email-Karthik.188@gmail.com>
X-Provags-ID: V03:K0:U7Dqutg+qytCZxbSijO17kOHHaaHHtN0uNYaavMFcq8LqqQ3IHS
 eZ6jIqmhqDK75mVfyo5MvvBG/MFdcF3S9sIY6FdBaK4qg2knbTiWa2J7wgjp+4xdhg+hkBe
 h1Vr7g8jybMli4Al5v9GS3j8OqsVkivABs9wD4ERE7+EfYwgXAzyFOo91Bg3D6pp/bVXtf+
 NFdY/cI52PgPnf+AGcTJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VKux71d2mjA=:IUgKhz73WvsNqrVA0vChpN
 eOldXECC6d8tNdl1Pe1+JxarSM6Rw8Isj5L4ZhcqF1VAzZ5AM7XMv9RBQtdPN4Ey6vSPSQm4H
 usygt5BgrC4BivVO+4LV7JiPgN04OostxS8nCkkiDekAOkPH4btUK1Qa8B/IhP23q7firNGGg
 CeRQnpa5Jjld6oIKLxTVxTxQQDGTsPpmQ6afVO8GASjMk4GjGYUBWgYocvkm8ezNdtI+bTgWc
 ybbnFzWKFK7QG0SlhbvsYYBP8CCGyIcXzGBD9eKaG0vkPCXLTTfQ0zIlznwLpwo8CVzVR9AIT
 3L+dOOHEfvOH6o8ZPyWSK1nYKwnST/g/vltGHkslSMDGLZRpPs3fpv28VCxvYGV6q+gSl3ety
 v06LqyrJ4eIR+uzPIgaqtN4YDkosVSheTf4QQypcJ5L21/7B6yG4JkPFAqz6QNfTgvrrjUcPm
 EJd5bgxScuSabfh1PwvsltBXtYeoe40eVvYttj7gNyXjcg0V8eAYNBcJnAZc/fyoGaeZ25WHD
 Mk+J2A+Gm+JmkjxUdnO8Re+3c93MdRb3vTiCqEfSqdtRPe5z1rYO5V/rEGb4JYMcr/vyvsdTW
 UnPxtImrIPz4d+KY2/05LQOMZUVcbX8ZrP47SHiZOTuYlAhGOCsbQjSF6+pRUqTd3K90t/MHh
 Vx8KOLdsKTukgyxUCeG/pslGqeFsViJ0l12VcH52Uc22CeW9otVpAtkQj06xsbJcngijpxqao
 B1ti3cRxQAslKA3BkzH65Fe9tJsa8oCLVEtkZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276792>

On 29.08.15 16:12, Karthik Nayak wrote:
> diff --git a/utf8.h b/utf8.h
> index 5a9e94b..7930b44 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -55,4 +55,19 @@ int mbs_chrlen(const char **text, size_t *remainder_p, const char *encoding);
>   */
>  int is_hfs_dotgit(const char *path);
>  
> +typedef enum {
> +	ALIGN_LEFT,
> +	ALIGN_MIDDLE,
> +	ALIGN_RIGHT
> +} align_type;
should this be called strbuf_align_type ?

And is there a reason why the is in utf.c and not in stbuf.c ?

(I know that there is a lot of strbuf in utf8.c, but I hadn't managed to send a patch
to move everything into strbuf.c and make utf8.c un-aware of all strbub-business)
