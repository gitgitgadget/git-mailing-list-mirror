X-Greylist: delayed 358 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Dec 2023 07:25:18 PST
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384218E
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 07:25:18 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id EE54FCA1254;
	Thu, 14 Dec 2023 10:19:19 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:4150:b4a8:ce67:6133] (unknown [IPv6:2600:1700:840:e768:4150:b4a8:ce67:6133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id C66E7CC8391;
	Thu, 14 Dec 2023 10:19:19 -0500 (EST)
Message-ID: <e5295dbe-94d2-3186-5663-2466eba4bdde@jeffhostetler.com>
Date: Thu, 14 Dec 2023 10:19:19 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: What's cooking in git.git (Dec 2023, #01; Sat, 9)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqa5qknnej.fsf@gitster.g>
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqa5qknnej.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 12/8/23 9:02 PM, Junio C Hamano wrote:
> --------------------------------------------------
...
> 
> * jc/diff-cached-fsmonitor-fix (2023-09-15) 3 commits
>   - diff-lib: fix check_removed() when fsmonitor is active
>   - Merge branch 'jc/fake-lstat' into jc/diff-cached-fsmonitor-fix
>   - Merge branch 'js/diff-cached-fsmonitor-fix' into jc/diff-cached-fsmonitor-fix
>   (this branch uses jc/fake-lstat.)
> 
>   The optimization based on fsmonitor in the "diff --cached"
>   codepath is resurrected with the "fake-lstat" introduced earlier.
> 
>   It is unknown if the optimization is worth resurrecting, but in case...
>   source: <xmqqr0n0h0tw.fsf@gitster.g>
> 
> --------------------------------------------------
...
> * jc/fake-lstat (2023-09-15) 1 commit
>   - cache: add fake_lstat()
>   (this branch is used by jc/diff-cached-fsmonitor-fix.)
> 
>   A new helper to let us pretend that we called lstat() when we know
>   our cache_entry is up-to-date via fsmonitor.
> 
>   Needs review.
>   source: <xmqqcyykig1l.fsf@gitster.g>
> 
> 

I think these look good.  And yes, it is better to insure that the
stat struct is always well-defined rather than sometimes uninitialized.


FWIW, in
f954c7b8ff3 (fsmonitor: never set CE_FSMONITOR_VALID on submodules, 
2022-05-26)
we try to never set the CE_FSMONITOR_VALID bit on submodules (because
status on a submodule is much more than just an lstat check on the
submodule root directory and we always should recursively ask Git to
compute the submodule's status).

I haven't had time to investigate, but I wonder if the original
complaint on `diff-lib` was due to another code path that allowed
the CE_FSMONITOR_VALID bit to get set on a submodule entry.

Jeff

