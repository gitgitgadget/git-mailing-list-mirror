Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVTkqV8V"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEBD1AE
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 10:33:05 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so18355495e9.2
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 10:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701196383; x=1701801183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxT+sy7A9MOWcjV183bAx/p7GpVw3r13IVnK6ATwedc=;
        b=IVTkqV8VA1sFbzbeJywivyhgkPUrdVmfvaoXXukG1X3BQZ5q5RXIko0f/WT42lu93p
         L4l2e6TV+5Onyr30SA7TuoegHAZZAv9kK/+Tr4/eEwYSufrLBhNgmTANT21jLCPXOuTk
         g2BlrEzzkwh6IXOF7n1AMlHPu6M8XFyTIqKvishudZ/W6gHQ+1qvbiOepcmrTtvr68mv
         QycquqFs/axNq3yMYzdYL6KoAMyC+GZzcL5FZn+DDEL6D2u8qk+Wnm8MuZSzhHy+D5ey
         iaEP0B1t58jPRMsLlLrzknpwiFCAl9UAuv09Depd2eFSRNDQ8T3ztUMPfPLXmSM4HKLY
         lKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701196383; x=1701801183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxT+sy7A9MOWcjV183bAx/p7GpVw3r13IVnK6ATwedc=;
        b=W+/yU4jj5IDi8XpF0MBUgO81w2leKNkr5AAy446lpQY9E1ccn7YDUVGFbd/bddq16p
         1RqYIcJAkTiF1iw36ZUsBtwIfoGT+leD2vKnd/Qr/7boGj/jnegMMYVYuoh+zM29bfKz
         iDynCVJRrRc6VpsBm55U917VIYOaGBKZ/GcUDBwKYnd55nb5qu0qwdtO41xR60ukxPMk
         dGC7yx6Nr3dOW0P/YQFZQrZxz1+NHmG8FJYhMODHZZ15k3N7+D6ZhzirvPxpzO1ReYBt
         D5AO6+vNLN3omOw8LG0pCu+qHjeqOx/Ck2WRayXwb5ULUJKgjzJOppHUw+/YTCal9iIR
         yz2w==
X-Gm-Message-State: AOJu0YzOX3QlSoL1zZXi2yRHo63veOSyofWmpXNRgToiIZybylQsoM28
	l1UJSZ6NOTx4FTVEH+fPXea2rTsTmVU=
X-Google-Smtp-Source: AGHT+IGppWb828bjVKugnzABYeWEjcErI79RDbowBF8mFoFDOQl8xBAK2LGAaFa2hLeUAMwKxrENFg==
X-Received: by 2002:a5d:4804:0:b0:32f:7b89:2675 with SMTP id l4-20020a5d4804000000b0032f7b892675mr11854093wrq.65.1701196383264;
        Tue, 28 Nov 2023 10:33:03 -0800 (PST)
Received: from localhost.localdomain ([2a01:11:f30:4040:4d56:70a3:1b54:a168])
        by smtp.gmail.com with ESMTPSA id l9-20020adffe89000000b003330a1d35a8sm3005593wrr.43.2023.11.28.10.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 10:33:02 -0800 (PST)
From: Ricardo Abreu <ricardolafabreu@gmail.com>
To: scott@tannewt.org
Cc: git@vger.kernel.org
Subject: Re: Submodule update fetching with outer repo's default branch
Date: Tue, 28 Nov 2023 18:32:53 +0000
Message-ID: <20231128183253.134480-1-ricardolafabreu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <111c2777-6fd4-45ab-8418-9d064999661c@app.fastmail.com>
References: <111c2777-6fd4-45ab-8418-9d064999661c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have the same problem. Here is a generic recipe to reproduce, assuming a repository X with a submodule Y (set with an `https` URL):

1. `git clone ... X`
2. `cd X`
3. `git submodule sync`
4. `git submodule update --init --recursive`
5. `git remote rename origin remotex` # rename the remote in X, not Y
6. Elsewhere, add a new commit to Y and create a branch "update-y" in X, pointing the submodule to that commit. Suppose the hash of the new commit in Y is `abc1abc`.
7. `git fetch remotex`
8. `git checkout update-y`
9. `git submodule sync`
10. `GIT_TRACE=1 git submodule update --init --recursive`
  - observe: 
    * the command in the last trace message to be `git fetch remotex abc1abc` (should be `git fetch origin abc1abc`, because that is still the name of the submodule's remote)
    * the wrong error message complaining about 'file' protocol (which isn't involved anywhere)

