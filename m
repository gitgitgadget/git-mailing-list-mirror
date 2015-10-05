From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/43] refs-be-files.c: add a backend method structure with transaction functions
Date: Mon, 05 Oct 2015 10:25:11 -0700
Message-ID: <xmqq8u7hz0qw.fsf@gitster.mtv.corp.google.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	<1443477738-32023-19-git-send-email-dturner@twopensource.com>
	<56122EB6.2020501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 05 19:25:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj9Vq-0004CB-44
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 19:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbJERZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 13:25:16 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35271 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbbJERZO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 13:25:14 -0400
Received: by pacfv12 with SMTP id fv12so186216201pac.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/2IutLATwOscDnSSFUHPA9+dYnMvIjAvm7rsV/TB1cA=;
        b=GGGlizvOB8VDx6NCcXH2y4RbAO3BiP3gkmuAvuN+cq59+QhSxmGRVzStYB7XnV/Oyo
         6zW+pZtTfKzz8JfwsNm3rOM5b7r1Y5rAXtbM/QHsh/kBovIYNft3KNa5NAupKGgZcWb/
         AmFjyv8TErlaF8dYg98bkcNxLjyv3Uzue9TPcpC6HqV1VuhoPvTwLKpwnPSZchzkAHVf
         nlrw60wDKX46fS3QnS1a9zOtiXCR32Xgf81XjijPHCIil0sYzWpQHRddMygvTpItLDL7
         d2WVQlIVmgmUm9pePrVSK6d5dpNR8e28G6z/xG5edbNRuHGrWrCMMsxMOyLJn61824lC
         3KtQ==
X-Received: by 10.66.222.70 with SMTP id qk6mr41855542pac.68.1444065914228;
        Mon, 05 Oct 2015 10:25:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:60e8:cc09:ddf4:4eed])
        by smtp.gmail.com with ESMTPSA id pc8sm28749850pbc.27.2015.10.05.10.25.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 10:25:12 -0700 (PDT)
In-Reply-To: <56122EB6.2020501@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 05 Oct 2015 10:03:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279062>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> +/* refs backends */
>> +typedef struct ref_transaction *(*ref_transaction_begin_fn)(struct strbuf *err);
>
> Hmmm, I thought our convention was to define typedefs for functions
> themselves, not for the pointer-to-function; e.g.,
>
>     typedef struct ref_transaction *ref_transaction_begin_fn(struct
> strbuf *err);
>
> (which would require `struct ref_be` to be changed to
>
>         ref_transaction_begin_fn *transaction_begin;
>
> etc.) But now as I grep through the code it looks like both conventions
> are used. So never mind :-)

Well spotted.  My recollection is the same and we do prefer the
latter (I think all early function typedefs by Linus were done that
way).  It would be better to correct existing mistakes we added over
time and certainly not add more of them in new code.

Thanks.
