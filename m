Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubsado.com header.i=@dubsado.com header.b="vBDAUo1T"
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A837E1BE
	for <git@vger.kernel.org>; Tue,  5 Dec 2023 19:41:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d05e4a94c3so43696315ad.1
        for <git@vger.kernel.org>; Tue, 05 Dec 2023 19:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubsado.com; s=google; t=1701834090; x=1702438890; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a//qyBtVNiUbx+EWvq0k5xfcQwluA7EOuv8aF3yxIPk=;
        b=vBDAUo1ThZkGPpuI2whHiIzBtVh+Dpe2x+fU5bPv7iR6XD6G/0fCCIJDMvIrT3/JJj
         8AcWl6lVuXEEgU/TjHodCpmP7L5jYfbfvb0UwMwbRBPdqmJxmxX9Ve04jNFP6hn6i65Y
         NmA8nd8z5lJzBVLs+X6dHydzQFqqnbsNxPiGdkuKrtjfJ37cc1X2hPC1u/0n0MbzndYL
         1C5VfDGVKIpoSi6oDfBLRONsfRpnLim9/ZPap7B68KifDgrC2OdgAvqhTAqvWMUThMZ5
         4QGT6lIyPqbkeF6zUY5ObP5OzDSSOifHZQiIwsmiyxcaQFx+G4o+/S12ieH5QCvxTsYJ
         9INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701834090; x=1702438890;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a//qyBtVNiUbx+EWvq0k5xfcQwluA7EOuv8aF3yxIPk=;
        b=XLg5kgDNPcfGajR67tEn07Jz5MDOseIapLVRON+XwuFxuMOsRRLZZHtqfGTsN4S8Aj
         UEt7ra/PCTv26sQVmi85cs2+oPGWXDVA1ZqFjnjiXEywtJlJoEtWNZNrLzj4yjaO3GjO
         tZ0fCS4vX42Flf4qMiGpDaLOSqdKH4tViZqhoahdgKgd6eEtiVWWOVqrTTDLN6AOTCM9
         fH8BuK2wSH7hC3JrJMPldMZnY5S//wxjnrTxOyRsTG7twFtoGTDsHOhwYPlfbo0G5Wgc
         SWTxxzdyfkqFApsJZlCTMKTEN+AO/MjH1uf5c/BYS9RxnhYlIms9DUejxoxB7WEBPFd/
         erpA==
X-Gm-Message-State: AOJu0Yw1Yiy67IOojQc75bti+5BtkT/ZcqYRxABFe/RDBJGizVRUTLDB
	4ktMQKJGCNoZaSCTitquJyQygtgfo5M1730DzNQ=
X-Google-Smtp-Source: AGHT+IGpBtAeD35BrrzsMy0MxZdPYJGmWpnTveDDkc1qHQlEl3uGWbdMfX8z1o/UBM8lKP0ck4CG4A==
X-Received: by 2002:a17:902:d4c5:b0:1d0:b315:91ef with SMTP id o5-20020a170902d4c500b001d0b31591efmr301888plg.24.1701834089976;
        Tue, 05 Dec 2023 19:41:29 -0800 (PST)
Received: from smtpclient.apple ([198.59.164.90])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902820900b001c9c8d761a3sm7540280pln.131.2023.12.05.19.41.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 19:41:29 -0800 (PST)
From: "Jeremiah Steele (Jerry)" <jeremiah@dubsado.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: git switch has fatal dependency on default fetch config
Message-Id: <634F40AF-25F8-4FE6-BDE3-08798E699A9E@dubsado.com>
Date: Tue, 5 Dec 2023 19:41:28 -0800
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.3)

Changing the default fetch refspec for a remote breaks git switch:

% git branch -r
  origin/HEAD -> origin/master
  origin/feature
  origin/master
% git remote set-branches origin master
% git switch -c feature --track origin/feature
fatal: cannot set up tracking information; starting point =
'origin/feature' is not a branch
% git remote set-branches --add origin feature
% git switch -c feature --track origin/feature
branch 'feature' set up to track 'origin/feature'.
Switched to a new branch 'feature'

It seems like I should be able to fetch a remote branch and track it =
without having to monkey around with my default fetch config. Is there a =
reason git switch has a hard dependency on the default remote fetch =
refspec configuration?=
