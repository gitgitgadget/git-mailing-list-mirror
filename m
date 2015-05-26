From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/WIP PATCH 07/11] fetch-pack: use the configured transport protocol
Date: Tue, 26 May 2015 15:23:10 -0700
Message-ID: <CAGZ79kbuU1YwhxCnT7YRN=-cBsY0R820Mm2QTHJuMBju6r8Zew@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-8-git-send-email-sbeller@google.com>
	<xmqq617fj81l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 00:23:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxNFl-0003hO-3o
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbbEZWXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:23:12 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34589 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbEZWXL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:23:11 -0400
Received: by qkgx75 with SMTP id x75so101981199qkg.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l+LBHETBz3uYr6kQcFMtvpKDvDhq2GcCKK7cNdSuysA=;
        b=iFKGnbYxCbDL+L7LAiQ+lJQ0shn7O+GB0cSPsndafiwT4GPf7UikEXfHeqDeH4Zfqp
         aBBouue+hnHjidbae1+Qc21LhuPsH0zpmLgOigO/JarT9TvnvV9eY6W3pnpDnBOCU+1D
         p7Hi1aHDFx3Y7pSPdXqKkikFQMKDE9YDjkLmb73m2wsVHQeUwpVZhV/mlB+oL7RwwkiT
         JYvHbpVzeACtQfAhhRPWqeEo0XZvWR3++jIuU45HZJZZJpDI6e/kwNty1ybT1Xf5R5VX
         6KSBYvTKcVvs3dWACcjxKxi+WsD3vypVrIKJ6lshZShTI1qqhoQAnhG/0lmohsXdsx/K
         iCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=l+LBHETBz3uYr6kQcFMtvpKDvDhq2GcCKK7cNdSuysA=;
        b=NIgrMRQHLZXPZT8GbVQejQxECm8vTRbxa7mfN4HPVgVeIGZZENvCGYFgRq48Xn9n1r
         hqo2KKuQP7WcjTJgQ14hP2Ma3pe4Ror0joBr4Q/Xz1eSeCzB9AhNWn1bJFwPq1JBMRPj
         9s9WFM8ElFnDgpqTb1LAQUg4CGBGemeIwhOlV0XHu3nSORIt3ou0iDhwDbPEfp2JLVyU
         MWeKAJ6bbta2AZbf7zVcNJjAYhR4DUHJpDcoJcLBwbWIsykvONfGdHpA1l94PTFFUwSw
         MurfziS+ktDHbXXND871yU+Ffhbwp0Q8JnJByhK7i43hAxufEP6VtKBK6IBn53WGLSSH
         G1dA==
X-Gm-Message-State: ALoCoQk3KVZ/l9remRbUvHdPM4Nli5jRymjIQai0sj496plaHEEHe8XOuZ/47EpLNQgv3VO+Je/d
X-Received: by 10.55.42.82 with SMTP id q79mr14236037qkh.84.1432678990779;
 Tue, 26 May 2015 15:23:10 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 26 May 2015 15:23:10 -0700 (PDT)
In-Reply-To: <xmqq617fj81l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270003>

On Tue, May 26, 2015 at 3:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -175,7 +179,18 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>>               if (!conn)
>>                       return args.diag_url ? 0 : 1;
>>       }
>> -     get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
>> +
>> +     switch (args.version) {
>> +     default:
>> +     case 2:
>> +             get_remote_capabilities(fd[0], NULL, 0);
>> +             request_capabilities(fd[1]);
>> +             break;

Actually this is wrong, we need to actually fall through from here as well,
so we not only talk capabilities negotiation, but then continue
with get_remote_heads.

>> +     case 1: /* fall through */
>> +     case 0:
>> +             get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
>> +             break;
>> +     }
>
> Nice ;-)
