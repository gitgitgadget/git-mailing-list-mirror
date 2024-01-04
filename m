Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF9208A9
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="IhE8/qIW"
References: <1536a5ef07ad24dafb5d685b40099882f89e6cc5.1703761005.git.ps@pks.im>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1704360404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CM54B2TpyB3R4JvpPZDf0j2JcELWkxdJyrJFGCbUk+s=;
	b=IhE8/qIWtA222PZI/TSXyrC23Wi/4OUTKvps9cLebFaYB3ZxZSam8yCYgANX955vEyKc8d
	XV1MyR83dti6R7j1cqwHd5jmz4Kj/t5/6E/r9Eb4luuYMAsc0noejqHhPKyHmaVNgaOw1Q
	sqj9B0zn3gpft3SxFEG82dDuzFddnmk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ci: add job performing static analysis on GitLab CI
Date: Thu, 04 Jan 2024 10:19:31 +0100
In-reply-to: <1536a5ef07ad24dafb5d685b40099882f89e6cc5.1703761005.git.ps@pks.im>
Message-ID: <87plyhfo00.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT


Patrick Steinhardt <ps@pks.im> writes:

> --- a/ci/install-docker-dependencies.sh
> +++ b/ci/install-docker-dependencies.sh
> @@ -21,7 +21,7 @@ linux-musl)
>  		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
>  		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
>  	;;
> -linux-*)
> +linux-*|StaticAnalysis)
>  	# Required so that apt doesn't wait for user input on certain packages.
>  	export DEBIAN_FRONTEND=noninteractive
>
> @@ -31,6 +31,11 @@ linux-*)
>  		perl-modules liberror-perl libauthen-sasl-perl libemail-valid-perl \
>  		libdbd-sqlite3-perl libio-socket-ssl-perl libnet-smtp-ssl-perl ${CC_PACKAGE:-${CC:-gcc}} \
>  		apache2 cvs cvsps gnupg libcgi-pm-perl subversion
> +
> +	if test "$jobname" = StaticAnalysis
> +	then
> +		apt install -q -y coccinelle
> +	fi

I was wondering why this was added, because I would assume the GitHub
Workflow needed this too. Well, it seems the "StaticAnalysis" job for
the Workflow runs ci/install-dependencies.sh instead of
ci/install-docker-dependencies.sh. The ci/install-docker-dependencies.sh
script is only used in the GitHub Workflow for the "dockerized" jobs.
They set $jobname to "linux-musl", "linux32", and "pedantic", so this
change is not affected by that.

Bottom line, changes all look good to me.

--
Toon
