Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2989C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 08:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbiDYInR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 04:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238484AbiDYInJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 04:43:09 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ED775231
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 01:40:06 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e2442907a1so15306691fac.8
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hSsjGaqOnXDv/XiQwPNUN3BGndX/TJ5TrVKxoKB4MgA=;
        b=j7DSw6H7R57/nWZwXRSRGYi1g1CafQrWeQUsT//j2/ztnWnjNkPUiOh0/Sfpq1Nyqn
         RuRezMvSt8Q4Ii0GJp/Lh/o7tvbRewd/qDf5p3mi49lPyTeefdg0QLU/T5xzOOu12oJm
         aYKBFao4TI9UCYbFxL5hCfbLNukrByM6hdMo6fhmaz2fWfxO+sdnWkp+G4O2Itx8V/e1
         Pc+g4W+BXM6nuWbQ9Xd841VYAc8IVIgL3xYEVAh8rbc1EcB2uqj3VwRQM5DLgdqhLpxT
         nR5Qf10u5a0UqlAkMaFLFGLMFFPHt4Wd/47b4T2U3O5Vv2Lg5w2AdtCMl06jnERMxfcg
         A4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hSsjGaqOnXDv/XiQwPNUN3BGndX/TJ5TrVKxoKB4MgA=;
        b=i9lmZBm3ZEMgM18Clo52thgw448J7Wev+5biyk5ojcY3HOu06c0ZvCa2ULDkMty3LJ
         rHYVvEAepV3FrLkFIgZHyeqyBMlspIvye9/rQyy8XL1C7R6GRsRS8OOzEh7teKJOo0y5
         sz6VVu/RxkfkX5g03lAHj6wiHE6ZS/GbngFxDkTrIG8M51JvMKeN/ssjp4Kqy0A99Ls7
         jpEcTR01GJ2YddXuIJ1CXZMgoqf9EIGHa9mQO1ILEjRUt9HICgnPE8o4EvXtGILWd+2P
         PGZUEA5/RumJ6Cy+273UT1F1eyoMLTSYOyeZ6qktjnHEoNIbpwg8HOfC1QbN2P+PCRdL
         tSoA==
X-Gm-Message-State: AOAM530PDvRVe2rnzBEpQPtXULwc+nr1m4UUokuDWvYnarVjr+5V1suo
        qQx589AT7b2kV5x7pLXpW+E=
X-Google-Smtp-Source: ABdhPJx/n8sRlHeglizT1nYkLJ2rbbbFeOgZgJzUigB+zUjq7NgZFsgfd/XrXBEX0HCkaLF/WLeu0g==
X-Received: by 2002:a05:6870:a109:b0:e6:8760:bc96 with SMTP id m9-20020a056870a10900b000e68760bc96mr6205482oae.40.1650876005577;
        Mon, 25 Apr 2022 01:40:05 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f15-20020a9d5f0f000000b005e6b67945a3sm3595268oti.15.2022.04.25.01.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 01:40:05 -0700 (PDT)
Date:   Mon, 25 Apr 2022 01:40:03 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
Message-ID: <20220425084003.nf267feurpqyvmsd@carlos-mbp.lan>
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
 <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
 <xmqqczh73hns.fsf@gitster.g>
 <xmqqk0bf1i12.fsf@gitster.g>
 <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan>
 <xmqqy1zty8dc.fsf@gitster.g>
 <20220425070245.ta6wibzkezlfwzxp@carlos-mbp.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425070245.ta6wibzkezlfwzxp@carlos-mbp.lan>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 25, 2022 at 12:02:45AM -0700, Carlo Marcelo Arenas Belón wrote:
> On Sun, Apr 24, 2022 at 11:39:27PM -0700, Junio C Hamano wrote:
> > Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> > 
> > > At that point, though you might as well excempt root from this check
> > 
> > But "root" or any higher-valued account is what needs this kind of
> > protection the most, no?
> 
> correct, and I didn't meant to excempt root from the protection, but
> from the check that requires that the config file ownership matches.
> 
> if the config file is owned by root, we already lost, regardless of what
> uid git is running as.

apologies for my confusing english, hopefully this C is clearer

diff --git a/git-compat-util.h b/git-compat-util.h
index 58fd813bd01..6a385be7d1d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -440,9 +440,19 @@ static inline int git_offset_1st_component(const char *path)
 static inline int is_path_owned_by_current_uid(const char *path)
 {
 	struct stat st;
+	uid_t euid;
+
 	if (lstat(path, &st))
 		return 0;
-	return st.st_uid == geteuid();
+
+	euid = geteuid();
+	if (!euid && st.st_uid && isatty(0)) {
+		struct stat ttyst;
+		if (!stat(ttyname(0), &ttyst))
+			euid = ttyst.st_uid;
+	}
+
+	return st.st_uid == euid;
 }
 
 #define is_path_owned_by_current_user is_path_owned_by_current_uid

it uses stdin instead not to fall in the issue that was raised by
Gábor, but I am affraid that it might need to check all stdnandles for
a valid tty to be safe, and it looking even more complex.

Carlo
