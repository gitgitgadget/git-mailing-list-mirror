Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1ABC001DF
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 13:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGKNbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 09:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGKNbg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 09:31:36 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D570C134
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 06:31:35 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7672073e7b9so417107385a.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689082294; x=1691674294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd8SBQJJ6ACf556xLPz6DjesajgEMuQJZ2vBMrq/GLs=;
        b=YCTkb1AaGyQXqUVa26wjuUQODl/DG9wFh5bOXMoNwOOONGAWzTN/tbBFEU/CRkZQ8I
         gS9VCTg+rVKo1gBkQ0jKE1pX1BEwkk4RXfIEoX+9eHcHdhc9RcaTkbGeCGag02PAPRpc
         wXqG8nfNUv6Jm9ye+K1DosXP07PNhtXD01oqdRLrS58FaqZ94Lg0J57G/SX2IVYUAgX8
         f8JTXug/GG19FXly2A5MlkCo1tndR8KuK44nmXwF9hsgeOVrcGApCwHO4VDZkr28DqPZ
         1Ly3NZY/OQIkmp91497lMfQ9JcOvvoxs8xVFygX1Ai03LZ86AggsuLlSIKbXbAUIeTuu
         JTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689082294; x=1691674294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pd8SBQJJ6ACf556xLPz6DjesajgEMuQJZ2vBMrq/GLs=;
        b=MrkIL6J9xRVzyN36UOA5CpWfo+fvEFJfhjAjaDe9XKmOwvHLDShRt2mSbLBHvCJPxh
         w189OzYKuLtcKFUBTcNwtXi6hsJU2Yz3NqJ1nL4ZskMAAtXhad8ecUaQxIjigdgx6o9Q
         gv2nHZ5ogZyCQzPQvKHSE6fNyqnygXIjcL4rhHpqbmPM7vYK8b8kYVISyj37uNwXFfym
         FdZBgyQv8GZ88JgxBiFozXORJRjePuw8V1mDQxmPUCXtaSodIWZuTRnfF4SA3U4gJqth
         Hf8NVsvr3ZPpvpIs0NKFlLjKX8IF5/gayR0yWDYFYk9qtMHgi57l3UuDEqEQyAWr9QYe
         cBeg==
X-Gm-Message-State: ABy/qLZKHzs1dApYt8hChMDFNZbPDy5Ur95D0b+io3k+VC4k8UXgWTO3
        U/kHbk+0any6esnB/ApaKEt69lCCSuw7HQ==
X-Google-Smtp-Source: APBJJlHRTjABJ4ZBvzNHtMpRvqACdglJFpwHW53zOKsstr43/pSn9kaDC0taiwkPeQrdByHlin89iQ==
X-Received: by 2002:a05:620a:3c0e:b0:767:2736:ecae with SMTP id tn14-20020a05620a3c0e00b007672736ecaemr11665066qkn.74.1689082294509;
        Tue, 11 Jul 2023 06:31:34 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id oq5-20020a05620a610500b00766fbeb3e7csm966010qkn.132.2023.07.11.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:31:33 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v3 0/3] check-attr: integrate with sparse-index
Date:   Tue, 11 Jul 2023 09:30:32 -0400
Message-Id: <20230711133035.16916-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707151839.504494-1-cheskaqiqi@gmail.com>
References: <20230707151839.504494-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

change against v2:

* add SP at appropriate places

* add in-code comment around magic "adjustment"

Shuqi Liang (3):
  attr.c: read attributes in a sparse directory
  t1092: add tests for `git check-attr`
  check-attr: integrate with sparse-index

 attr.c                                   | 47 ++++++++++++--------
 builtin/check-attr.c                     |  3 ++
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 55 ++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 19 deletions(-)

Range-diff against v2:
1:  0ff2ab9430 ! 1:  199cc90a5b Enable gitattributes read from sparse directories
    @@ Metadata
     Author: Shuqi Liang <cheskaqiqi@gmail.com>
     
      ## Commit message ##
    -    Enable gitattributes read from sparse directories
    +    attr.c: read attributes in a sparse directory
     
         'git check-attr' cannot currently find attributes of a file within a
         sparse directory. This is due to .gitattributes files are irrelevant in
    @@ attr.c: static struct attr_stack *read_attr_from_blob(struct index_state *istate
      	if (!istate)
      		return NULL;
      
    --	/*
    + 	/*
     -	 * The .gitattributes file only applies to files within its
     -	 * parent directory. In the case of cone-mode sparse-checkout,
     -	 * the .gitattributes file is sparse if and only if all paths
    @@ attr.c: static struct attr_stack *read_attr_from_blob(struct index_state *istate
     -	 * In the case of a sparse index, it is critical that we don't go
     -	 * looking for a .gitattributes file, as doing so would cause the
     -	 * index to expand.
    --	 */
    ++	 * If the pos value is negative, it means the path is not in the index. 
    ++	 * However, the absolute value of pos minus 1 gives us the position where the path 
    ++	 * would be inserted in lexicographic order. By subtracting another 1 from this 
    ++	 * value (pos = -pos - 2), we find the position of the last index entry 
    ++	 * which is lexicographically smaller than the provided path. This would be 
    ++	 * the sparse directory containing the path.
    + 	 */
     -	if (!path_in_cone_mode_sparse_checkout(path, istate))
     -		return NULL;
     +	pos = index_name_pos_sparse(istate, path, strlen(path));
    -+	pos = -pos-2;
    -+	if (!path_in_cone_mode_sparse_checkout(path, istate) && pos>=0) {
    -+		if (!S_ISSPARSEDIR(istate->cache[pos]->ce_mode))
    -+			return NULL;
    ++	pos = - pos - 2;
      
     -	buf = read_blob_data_from_index(istate, path, &size);
     -	if (!buf)
    @@ attr.c: static struct attr_stack *read_attr_from_blob(struct index_state *istate
     -	if (size >= ATTR_MAX_FILE_SIZE) {
     -		warning(_("ignoring overly large gitattributes blob '%s'"), path);
     -		return NULL;
    +-	}
    ++	if (!path_in_cone_mode_sparse_checkout(path, istate) && 0 <= pos) {
    ++		if (!S_ISSPARSEDIR(istate->cache[pos]->ce_mode))
    ++			return NULL;
    + 
    +-	return read_attr_from_buf(buf, path, flags);
     +		if (strncmp(istate->cache[pos]->name, path, ce_namelen(istate->cache[pos])) == 0) {
     +			const char *relative_path = path + ce_namelen(istate->cache[pos]);  
     +			stack = read_attr_from_blob(istate, &istate->cache[pos]->oid, relative_path, flags);
    @@ attr.c: static struct attr_stack *read_attr_from_blob(struct index_state *istate
     +			return NULL;
     +		}
     +		stack = read_attr_from_buf(buf, path, flags);
    - 	}
    --
    --	return read_attr_from_buf(buf, path, flags);
    ++	}
     +	return stack;
      }
      
2:  835e1176b0 = 2:  eefce85083 t1092: add tests for `git check-attr`
3:  672d692e51 = 3:  65c2624504 check-attr: integrate with sparse-index
-- 
2.39.0

