From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] preserve mtime of local clone
Date: Fri, 11 Sep 2009 22:09:12 -0700
Message-ID: <7vmy50lpfr.fsf@alter.siamese.dyndns.org>
References: <20090909195158.GA12968@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,  msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, "Shawn O. Pearce" <spearce@spearce.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Sep 12 07:09:45 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmKrn-0001iU-EU
	for gcvm-msysgit@m.gmane.org; Sat, 12 Sep 2009 07:09:43 +0200
Received: by ywh4 with SMTP id 4so4058074ywh.9
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Sep 2009 22:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=Hki/SDQjKrB9tsZ2+ex3lxe5FCZssAWtjcmBy+VQd2Y=;
        b=cXYpzCKH9p8OuxvpU8LQYHVhYjZiK9ixp2nhDvRETka/pUMN8foafbofhN4W66tMIk
         8VJLpP8TXMmBBeNEhM4LDVGv7Qkt/PfmixJVeXJ9vJQQWlB7WX8MYQFck86+9jGns8Uk
         Dl2B689iNy6mQn35VM818FfDtupaynZH+u1hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=akBPar7W/xIf2I+x4y5ic7BqGco6BqfRjJohSfNWaNmPdo6DJt1KcZh5ixHnOJhlfE
         Apilbsy9tnG4Xb3tAwwqwETA6/twuCQ6GHB9NPWpfGTupqr2g8dQJouMUdStfw27mxaC
         STTjKbB0Ytby1oXaJUthBlOD9tkXOuaDv6V6I=
Received: by 10.90.37.21 with SMTP id k21mr632550agk.31.1252732176635;
        Fri, 11 Sep 2009 22:09:36 -0700 (PDT)
Received: by 10.176.168.4 with SMTP id q4gr6925yqe.0;
	Fri, 11 Sep 2009 22:09:31 -0700 (PDT)
X-Sender: gitster@pobox.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.229.34.148 with SMTP id l20mr478647qcd.3.1252732169983; Fri, 11 Sep 2009 22:09:29 -0700 (PDT)
Received: by 10.229.34.148 with SMTP id l20mr478646qcd.3.1252732169959; Fri, 11 Sep 2009 22:09:29 -0700 (PDT)
Received: from sasl.smtp.pobox.com (a-pb-sasl-sd.pobox.com [64.74.157.62]) by gmr-mx.google.com with ESMTP id 19si535907qyk.4.2009.09.11.22.09.26; Fri, 11 Sep 2009 22:09:26 -0700 (PDT)
Received-SPF: error (google.com: error in processing during lookup of gitster@pobox.com: DNS timeout) client-ip=64.74.157.62;
Authentication-Results: gmr-mx.google.com; spf=temperror (google.com: error in processing during lookup of gitster@pobox.com: DNS timeout) smtp.mail=gitster@pobox.com; dkim=pass header.i=@pobox.com
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1]) by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6D66E4D3DF; Sat, 12 Sep 2009 01:09:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type; s=sasl; bh=Ieg+rav3K0euO1fN3rVs+0RcU6A=; b=Tk91Fe SFgPSMCBZNjzyedQNsm7vDXbrOxL9aRCHVSX3vHegGvHo/TFG+VL9PrZNJWbNIVR MnsF8lUnWSs2Wfl0M81sZFglMvLVazcovmV5GZrIL1apmkHPHrk8V4famHtDhyOY /2tPnVIYGlLb7pF+lc0+MjSx2CrlQKp4UNgMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type; q=dns; s=sasl; b=EBrdCfD1wbyfzCCEbGw3YR1gzIVoqBmi csZHFjbrU33zgrU8UdT4yOqOimWWjsEt1wYwfCyc9/VACu7bSLEZMwlUYPxO68tJ MOe5vQSgdIaX1D8hlboFXnA+KOb++MuEu7uL3OY0GtH3RICvpEVtuI9MJt3lJal1 YX6jbzXpsEc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1]) by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 392B84D3DE; Sat, 12 Sep 2009 01:09:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 485A34D3DD; Sat, 12 Sep 2009 01:09:13 -0400 (EDT)
In-Reply-To: <20090909195158.GA12968@localhost> (Clemens Buchacher's message of "Wed\, 9 Sep 2009 21\:51\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6E2B0C12-9F5A-11DE-8F2F-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128238>


Clemens Buchacher <drizzd@aon.at> writes:

> +int copy_times(int ofd, int ifd)
> +{
> +	struct stat st;
> +	struct timespec times[2];
> +	if (fstat(ifd, &st))
> +		return -1;
> +	times[0].tv_nsec = UTIME_OMIT;
> +	times[1].tv_sec = st.st_mtime;
> +	times[1].tv_nsec = ST_MTIME_NSEC(st);
> +	return futimens(ofd, times);
> +}

Hmm, futimens() is relatively new.  Are minority platforms folks Ok with
this patch?

At least SunOS 5.11 (OpenSolaris 0811) seems to barf on UTIME_OMIT.
