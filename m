From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 2/2] xdiff: implement empty
 line chunk heuristic
Date: Fri, 15 Apr 2016 13:06:31 -0700
Message-ID: <CA+P7+xopb-kz4ipvoH6q14F+Sc5vqqHG5z93NdxJJzKwg_TSWA@mail.gmail.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
 <20160415165141.4712-3-jacob.e.keller@intel.com> <CAGZ79ka7h25=rHun_hPv1qjqeghXt1UwUU3Q6xT0aj4+OW87fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:07:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arA1K-000105-Qt
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 22:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbcDOUHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 16:07:05 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38380 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbcDOUGv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 16:06:51 -0400
Received: by mail-ig0-f178.google.com with SMTP id ui10so32831297igc.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VzGUuxa5L33D/uy0CaA9o8ZBN2z6qhOU94tz82cmJq4=;
        b=H0RhJT1dM9hxnTqKsx2EnJRs/hSy+lynDPeSMQCK85koeFif5LK8w9MGrdtym5uf7V
         w1Z083aiSL3kgSYTBsbrmGeOUHtnqm2YjV9AvAQWyalIohbflSUcGvJYRwkT46yvhZpm
         lWb7vr5jBzvXp3J+rlMHyUPEvmbSAXuyVevCxPjXRAXnI4+yBFu4ZkvWg+vT4Ax/+GuJ
         dqS3ooUWbeY3N1HWMWvTRJM3NLmOaTzVLW9L4016kqHcRHS1iUcouLpMaOYi47KVayni
         qG9hX7s6hEbRVSGzSxWzjd5Br9zTGUKM4nk2+SXSuy5ma4YTMwuBQa/L4+3LFDTYRuDj
         FPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VzGUuxa5L33D/uy0CaA9o8ZBN2z6qhOU94tz82cmJq4=;
        b=iYoL8ADP2rmkq5P9s9eOlsBdSUid2/CqoVjPmgNpXHRG4kFDCudRJgmeSAsqV2IYib
         xKeM4T4lhENATDUCRhK8RROnprkyq9wTPhVy0ZJHhY9ieOGu3xy0jBQshzn7IzVt6A7B
         n1CKD3dBkfab50wf7CQLxkZpodYfOYKevZ8C2ILemYhn3YjQUyPbWBFdqWhW0nUtb+eg
         nMkw/y1ff6nbNjTR08VT7YXvchiYzVcjU3jrTXu5ChwOlwK8klMFM3NE2L4bGzN0cmcN
         /3iIC3gI+38Rj//aOaISm49eI8K4/zNEo1nxyiK2UzKNdCM7N8D2ekp68YpO3A96Zsh2
         HHcA==
X-Gm-Message-State: AOPr4FXdfhvNWlfhtZjNNQSnM6NYq9bmc40mJRX3Q+3DfxZrfxy4nbsLMkIBtIKtWq9SIm0c5KbLDieJA429rA==
X-Received: by 10.50.249.20 with SMTP id yq20mr7169616igc.35.1460750810822;
 Fri, 15 Apr 2016 13:06:50 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 15 Apr 2016 13:06:31 -0700 (PDT)
In-Reply-To: <CAGZ79ka7h25=rHun_hPv1qjqeghXt1UwUU3Q6xT0aj4+OW87fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291652>

On Fri, Apr 15, 2016 at 12:57 PM, Stefan Beller <sbeller@google.com> wrote:
> I was looking at the TODO here and thought about the name:
> It should not encode the `emptyLine` into the config option as
> it is only one of many heuristics.
>
> It should be something like `diff.heuristic=lastEmptyLine`
> The we could add firstEmptyLine, aggressiveUp, aggressiveDown,
> breakAtShortestLineLength or other styles as well later on.
>

This sounds better, but how does this handle multiple heuristics?

> I do not quite understand the difference between diff.algorithm
> and the newly proposed heuristic as the heuristic is part of
> the algorithm? So I guess we'd need to have some documentation
> saying how these differ. (fundamental algorithm vs last minute
> style fixup?)

It is not part of the algorithm. It's applied after the algorithm.
xdl_change_compact is run after the algorithm and run for all
algorithms.

These are last minute style changes, and should probably not use the
term heuristic, but somehow capture "last minute style fixup"

Thanks,
Jake

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
