Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3C658
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="thtdoAWb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=RqCylylT/3Fa1yR8Y2/E4s+eMRI9NBSp0T004Jlovrw=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=thtdoAWbkxkjvG7wDdiVnsIiK6bMCrzRqURBa/fPtTE1EBuLudjOTNtRCMAkHcWOcYqrXwhcsXAl
        je75+VUPqhaQtRAT4osOfnBWBEYkweD6KR7hwbE+HwmrMjZgwGFVUyMQ7rEe3XDq0mSo6uoRYGi6
        6SYSXQGUikYF0vH6m3Y=
Received: by smtp-relay.sendinblue.com with ESMTP id feae3401-b3cb-4bae-926b-4844b0b0986c; Tue, 09 January 2024 00:53:07 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTA5MDA1MzAzLjQ0NDkzMi0xLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Mon,  8 Jan 2024 15:53:02 -0900
Subject: [PATCH v2 0/1] completion: complete dir-type option args to am, format_patch
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id EF904520263; Mon,  8 Jan 2024 15:53:04 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4714b88d-df5b-4e37-a5d7-af5033cfb861@smtp-relay.sendinblue.com>
References: <4714b88d-df5b-4e37-a5d7-af5033cfb861@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <feae3401-b3cb-4bae-926b-4844b0b0986c@smtp-relay.sendinblue.com>
Origin-messageId: <20240109005303.444932-1-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: ayHVF3aEzEGLaf3TGUiOU6AxYlFs6hQmzS1u2n4pESc_MFUzt-XeMpb-iSmYEDcTybJxb5t1Jq-bnKShYZH1hVjEGc7FYODxe-qVIPILy9Ligu2QUEdE3Inwi1Ep-3GH4OVNUus8nmO-bMeLsa1auhvLvZExssKzTSK3dMoDRHEu
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

This revision adds missing double quotes to improve the completion
situation for paths with spaces in them, and adds some comments.

Britton Leo Kerin (1):
  completion: dir-type optargs for am, format-patch

 contrib/completion/git-completion.bash | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

Range-diff against v1:
1:  2d788b0b18 ! 1:  5161304a92 completion: dir-type optargs for am, =
format-patch
    @@ contrib/completion/git-completion.bash: =5F=5Fgit=5Fcount=5Fargument=
s ()
      	printf =22%d=22 $c
      }

    -+
     +# Complete actual dir (not pathspec), respecting any -C options.
     +#
     +# Usage: =5F=5Fgit=5Fcomplete=5Frefs [<option>]...
    @@ contrib/completion/git-completion.bash: =5F=5Fgit=5Fcount=5Fargument=
s ()
     +		shift
     +	done
     +
    ++        # This rev-parse invocation amounts to a pwd which respects =
-C options
     +	local context=5Fdir=3D$(=5F=5Fgit rev-parse --show-toplevel =
--show-prefix 2>/dev/null | paste -s -d '/' 2>/dev/null)
    -+	[ -d =22$context=5Fdir=22 ] || return
    ++	[ -d =22$context=5Fdir=22 ] || return 1
     +
    -+	COMPREPLY=3D$(cd $context=5Fdir 2>/dev/null && compgen -d -- =
=22$cur=5F=22)
    ++	COMPREPLY=3D$(cd =22$context=5Fdir=22 2>/dev/null && compgen -d -- =
=22$cur=5F=22)
     +}
    -+
     +
      =5F=5Fgit=5Fwhitespacelist=3D=22nowarn warn error error-all fix=22
      =5F=5Fgit=5Fpatchformat=3D=22mbox stgit stgit-series hg mboxrd=22
--
2.43.0


