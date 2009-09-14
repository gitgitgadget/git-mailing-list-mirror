From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/17] Add ftruncate implementation for MSVC
Date: Mon, 14 Sep 2009 12:48:41 -0700
Message-ID: <7vws41b946.fsf@alter.siamese.dyndns.org>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com> <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com> <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com> <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstorm
  o@gmail.com> <4931b7ac3102ee259353fe6b3c5ceeb2a67c53ba.1252925290.git.mstormo@gmail.com> <1b5c5e90392e813ffab4fd510b70e57903a451cc.1252925290.git.mstormo@gmail.com> <9c5670f92cd0b3b8b74dd2204698e9c45ad03c90.1252925290.git.mstormo@gmail.com> <c95a367520435feec0833d2d0edc33d86cf939a8.1252925290.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de,  msysgit@googlegroups.com, git@vger.kernel.org,  lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 21:49:12 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnHXw-0005J8-FJ
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 21:49:08 +0200
Received: by ywh4 with SMTP id 4so9769817ywh.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=FkjRFPNMVFv2kj5SGkf4G+NQNwX/0vya0bt0GGFScbE=;
        b=tmQt+Seih4RB/U15ABhz+A005s/f8sFXJCqSavPBl+ls/M99fEVV84Q5lLRNwIBlG2
         dbD2xT0QaziPPKOmlKampsB8cOnF3UgekpXwvkrTTG46FksLRufddcdnXfEkA2GNY3Vn
         FFtyKdFPG914oA66zCuIJNkRVO/V+3H38kbOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=DodOZLEucEznUr9I992c2ablIAtZvFynvmaZ5Z/GdaWm9+5x24/m2SOAxjRmdhsmaS
         9b7lo+K8m8SYAYW7bQWts2uTiiUZXZCYcJDjFKUgqilw6B5cF0iTDIVCVxcsCKxwubVu
         5H8X5aoD+NibtHAW5LFlEMvmnwAsyh3OjnK2c=
Received: by 10.90.190.16 with SMTP id n16mr1079032agf.39.1252957741463;
        Mon, 14 Sep 2009 12:49:01 -0700 (PDT)
Received: by 10.176.151.15 with SMTP id y15gr7000yqd.0;
	Mon, 14 Sep 2009 12:48:57 -0700 (PDT)
X-Sender: gitster@pobox.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.224.7.66 with SMTP id c2mr927730qac.7.1252957736124; Mon, 14 Sep 2009 12:48:56 -0700 (PDT)
Received: by 10.224.7.66 with SMTP id c2mr927729qac.7.1252957736093; Mon, 14 Sep 2009 12:48:56 -0700 (PDT)
Received: from sasl.smtp.pobox.com (a-pb-sasl-quonix.pobox.com [208.72.237.25]) by gmr-mx.google.com with ESMTP id 24si931999qyk.10.2009.09.14.12.48.54; Mon, 14 Sep 2009 12:48:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) client-ip=208.72.237.25;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of gitster@pobox.com designates 208.72.237.25 as permitted sender) smtp.mail=gitster@pobox.com; dkim=pass header.i=@pobox.com
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1]) by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 97F9B32D97; Mon, 14 Sep 2009 15:48:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type; s=sasl; bh=iWJI0K3ppk0aPp59RCvB6ISMPZo=; b=dMg3g/ d9wkoQwMcaUtbhD973wEDMMsmIhWL+mZcU+QZvmsmBdt9sNr/R+tYj1fu5YW4NTc nQQJgdHY9IlJAk1rFrLL3B123+xsmUluYjHKYClQMGzsNStKqY7k1ciIwZ1MYcX/ 4w07g6jod4tMsLhonpgl7E6Uwql0ziPZUFaII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type; q=dns; s=sasl; b=m7HsWkHkuc+jmA8aRyEwW90CEyJdcXkT 56tKeZD40Z8/4odQtUnEsJuFKXrOgaMUHEK8DKOCntesF9Ji0edywX2FTyQ/GElb wvEhrjLb5MZwmh630OO5EBQDZcEAaKwry2MLPJ3ey7wiAHW9f0mvDA9bWYPcmT9J YKMYryUBOUg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1]) by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54FE832D96; Mon, 14 Sep 2009 15:48:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51AB932D94; Mon, 14 Sep 2009 15:48:43 -0400 (EDT)
In-Reply-To: <c95a367520435feec0833d2d0edc33d86cf939a8.1252925290.git.mstormo@gmail.com> (Marius Storm-Olsen's message of "Mon\, 14 Sep 2009 15\:11\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9F40DAE8-A167-11DE-9E79-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128496>


Marius Storm-Olsen <mstormo@gmail.com> writes:

> The MSVC Posix implementation doesn't contain ftruncate, so add our own
> which can handle large files (64bit offsets).
>
> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
> ---
>  compat/msvc.c |    8 ++++++++
>  compat/msvc.h |    2 ++
>  2 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/compat/msvc.c b/compat/msvc.c
> index ac04a4c..b96b045 100644
> --- a/compat/msvc.c
> +++ b/compat/msvc.c
> @@ -32,4 +32,12 @@ int closedir(DIR *dir)
>  	return 0;
>  }
>  
> +int ftruncate(int fd, __int64 length)
> +{
> +	HANDLE fh = (HANDLE)_get_osfhandle(fd);
> +	if (!fh || _lseeki64(fd, length, SEEK_SET))
> +		return -1;
> +	return SetEndOfFile(fh) ? 0 : -1;
> +}
> +


Wouldn't it break this toy program?  ftruncate() should preserve the file
offset and use of the seek in the above feels iffy.

#include <stdlib.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>

int main(int ac, char **av)
{
        int fd = open("testfile", O_CREAT|O_WRONLY, 0666);
        if (fd < 0)
                exit(1);
        write(fd, "abcdefghijklmnopqrstuvwxyz\n", 27);
        lseek(fd, 7, SEEK_SET);
        write(fd, "H", 1);
        ftruncate(fd, 24);
        write(fd, "IJ", 2);
        close(fd);
        exit(0);
}

The only two in-tree users of ftruncate() do not care about this, though.
They both seek to the beginning and then truncate to zero length.
