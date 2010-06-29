From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH] Clarify text filter merge conflict reduction docs
Date: Tue, 29 Jun 2010 23:18:37 +0200
Message-ID: <BE5ECD39-0A80-410B-87C9-5C86F082773C@gmail.com>
References: <20100628080234.GA7134@pvv.org> <0cd82ad22a6f240ebcde0c2f3a437a805dae5668.1277753114.git.eyvind.bernhardsen@gmail.com> <7vk4phbyl5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 23:19:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTiD4-0000eF-Jn
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 23:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013Ab0F2VSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 17:18:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50749 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab0F2VSl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 17:18:41 -0400
Received: by wyb38 with SMTP id 38so55164wyb.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=egyEw5ae8ZK7KvzSdIKZQh08fBp+DTsNi46maDNEcbk=;
        b=n0QhtHQMEHv3On5E5MOgo7TdD5cHfmxBQ1dZ0ncPPPf1MsR+TzbMvOg0zXIeuxR9Z2
         he4dMkUm3BR6p8fQop0Lt9EM16TsGkOsLnlWLNqaBsOXF15Ez8ryaIb67V7maJCEOjr3
         qezWCm08IKycrI/RfliyKQwZm4ZC7GXvJnm6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=FB/qVc57t0jzvadb5G+JbswYmtGxeRTeE39KWeqRRmELQLUifmc14+Zohdc7VTqROV
         RF5tgnP0/rWCVlsPGielavBQy8l/R7hiXla8YbKaGOa/ssmEk06H00dFAhX8v/RdJ41K
         tAC9Hl6lcmJN4mQ2N5ZaWAP5Cl1nTM4QzfopI=
Received: by 10.216.179.147 with SMTP id h19mr5764817wem.81.1277846319725;
        Tue, 29 Jun 2010 14:18:39 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id w21sm6882782weq.45.2010.06.29.14.18.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Jun 2010 14:18:39 -0700 (PDT)
In-Reply-To: <7vk4phbyl5.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149927>

On 29. juni 2010, at 18.19, Junio C Hamano wrote:

> I do however wonder if this should be initially introduced as an
> experimental feature, guarded with a configuration option for brave souls
> to try it out, and flip the feature on by default after we gain confidence
> in it, both in performance and in correctness.

Agreed, and thanks.  Messing with the merge machinery unnerves me a little.

Shouldn't the normalization in merge-recursive be conditional too?

Something like this squashed into the delete/modify patch:

--8<--
diff --git a/merge-recursive.c b/merge-recursive.c
index a2c174f..49bd3d2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1079,6 +1079,8 @@ static int normalized_eq(const unsigned char *a_sha,
 {
        struct strbuf a = STRBUF_INIT;
        struct strbuf b = STRBUF_INIT;
+       if (!core_ll_merge_double_convert)
+               return 0;
        int ret = 0;
        if (a_sha && b_sha &&
            read_sha1_strbuf(a_sha, path, &a) &&
--8<--

Sorry about the whitespace-damaged inline diff, I'll redo the series if necessary.
-- 
Eyvind
