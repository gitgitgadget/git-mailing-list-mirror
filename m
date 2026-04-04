Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CCD208D0
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775340651; cv=none; b=EUj6x6793ITd7ErZsmUCv4CeW1Za6dsAoEbV4wlrgJ2ZyBBh0ahM/dO5ePtIpzp5LeIH0VP7OuG0PEUDkI1/3GuSliYUh/R44IPEuVvVI5cE8xTRgV92Lb6P7oHOxQMnb7VO1rDCJ1KzvDQtDwUoaeXHkvt9ypSSssFHKOGaC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775340651; c=relaxed/simple;
	bh=iUDIHpls3M18lyfzBK8Q2xZQKu5A7YOkczozfp0e9E8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jE1XmnCmztyJpKQQB2T2UsxX0yt/GkTAVHhGx4KxA5UMtcvITaaD+xhXdzxsvPxcQPGeeo26bo+6dBpKWF5qw0Yc8+LjGrh6Fc7ZyEgQ0UL/1z4Emw9BpRi3c+idoCQEuvi4ohekzmLLdBgFOVzVl/tkvUK5ymfN2YXTb+GM2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Y6wdZCrK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Y6wdZCrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1775340639; x=1775945439;
	i=johannes.schindelin@gmx.de;
	bh=Y5C7kTxv/gWNEBtp1Q/3EWpEgeLRPWh73YA4wZOgoPM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y6wdZCrKlTgStoqJhVzg1Pe4HKFjx8xtckiGVLVKQVuk1IDmLWsq2f7Ahi+Z2gkh
	 HvlD990gyCKwCtn7/vRiOLkjlUOcEoTvP2DgbGqbIs3T4My0686a7r/0Xi10ot+V+
	 O7nJaIbURxbYwkIm/2v7YQT6+BNlCxd0GofGqKju6hd9E2pkSkcSQ+11CkzuFHH3O
	 iUx92ZYNTOO162nWum/2fn/uPih/gZdPyK9MgGGn+b05+izhi9O/6RMRa1uFqioTI
	 Lh1tuDTcGwzjwvB8pn1Op24BQb5gpIzfxQ4YKaRJ6LfBhibZGjE/Yc+FyJjB+lih+
	 pPyBoqGR9FTxb6/heA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6UZl-1w6gLv2ssz-001cIc; Sun, 05
 Apr 2026 00:10:38 +0200
Date: Sun, 5 Apr 2026 00:10:36 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
    Paul Tarjan <paul@paultarjan.com>, Paul Tarjan <github@paulisageek.com>, 
    Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v12 13/13] fsmonitor: fix split-index bitmap bounds in
 tweak_fsmonitor()
In-Reply-To: <84ddbb30bb3862d4230ba1775d4c061832f2623f.1774937958.git.gitgitgadget@gmail.com>
Message-ID: <b96ed977-525e-c3fc-a626-db1a4b3da376@gmx.de>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com> <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com> <84ddbb30bb3862d4230ba1775d4c061832f2623f.1774937958.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PwKHU0Eyhl7+0rwW5mKTODbRtE7V6rNTi00asE4q82Jq7pqieE7
 RoKFqmtHmFyQB65DkUGKCfDAX57ajQaANqDj682mBsCDXOFD/ab3rsz/bdyJrYBlK2BU/Nc
 +Tb+iWHlVLigLdud7n5asgV8ONUqh5oOSEnVly5x07Pl0oaXbF+vrhHYv4qeblY5shV+u04
 uQiLzhQYr8C8svA1qosZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KEzTD5r+G6k=;ovr2qFML7qLt5rGfEBOCnPO89bE
 ZqrOAkqDVYza+YhCkOMXk4MvGuNHpTMX7xgz0txiJoN2GhnwNG/WNJfRaEDRRJ3pY9JmJ5Ye+
 U4xefblyMbiaNEwpDe0VkUXQJoJ8pzzIN5t8ka+nRyZlM06FeLQVRGqxektWhfHKeO86RNMuB
 wIdv3pOmHeOCGivzrTxck6CTptygoAdOA3GFa9TBSpiqj8E46mYanRss7yZh6i3UcwxLScNLK
 N3HlX/zMeT23zt2u7S4yOpUFvtYDfOGxkXf3849K1Zq6pREd0yiVJ4ldTpTpq/rZubOcgR13e
 9mswsPGC4Lk1yzWByQPXw2eq/vkZxgsV7S3OAMROWgn9yQtfi9VLUq8V6kS4toDd23dVBZQo+
 dQfjlbnM26rZ8lu70oTC8iybTTZ9jmF7grnSj/qEkfNzAg9J5S4ofNZFy44xa9EN1oVnNhjf1
 591JhMV+1swwiqSQ6XfHHSThO6+sM+MB+esH9hTxJUTl7Yultyem1B1a57oIlsPNDG2hRs3pO
 2ykwbgGYES7Omce4l37sXksXhn06u4ISUdw2g7UeCnHywSkbdjQuvd4cRgZcIWaULkZTbNfUf
 RH9LgGNukr9peFibXW5B81IVnmKdVq1Qsqk+8zYjcfTgmP/cJTpTkGW4MVrbVDY232sb7hjuS
 LmsfmPA0rIYDWaLi0/R7qEb2dfj/0Nh+2H02gO8C4+mPNcSsDkgFvkzyPgLf1XqFzcc8lzocV
 qll1Lyi0qlHZV0/uweqcjntfutB+wmxsBDbXVunnRlgMaZlj6QZcvjTvPTWhba/V1jcqF47Pt
 81gS87PHQLzXeFk2Q/r0emxgd2qIwXuUstVNhCz/XiZMlFdwjlNutqlbAJGkHqkYNPe9ItL/U
 EozGiQlqqARcCJnZvtsnRmhn6Nm9bhJxRHMiXrvn43XYF7L/eHJXTByPqM8E+VF0jQtfG8cA6
 xXB/PHHPV/7lbH9ufuHXki1D6x1GhDDqV7/U6oWNH71P+gPweZ6lLltQr9fhToc1yNR086HTk
 2bRZDUCRBmXtdFahBPSbYXTw7fx7fX2T+jTAzBm2MWCiPLJ8pNg3BIkoOIMrfP8Nlf4bJXEeH
 H7vZpFQJBZmLB2YkLd0Ca+II4ckcKGhtN2L/s2TaaPacRBMqiFjpBAUS5jgm5Owrvih0CiJXz
 YrvIO6mBVwpW+BzqoGdXjxWCEUAj8/L8+hmNHy+AD+6L8rMIUUNZ9Iv4QB+b6Yw0vXJFBxoil
 BQFsoQsxz4HU7UMj/8FodEiQH+31UAaMKreDfeYfeDXW+p88GFdDnO1fjAVMMZJ5STIJBOJVB
 HZok1XF9EqhJpJPmwC5pzrU0RDmnUSgdEMAs2vH1WevwQyqyYXtY+xRrug97hPUV1dHjt3wBz
 /PDh+ftfSt3uxNpzz4utgpAHHA7R7I4Sv/E/Wv4vM076ce1DjSCx9s8BTOgRWrcFmKj0qyuAY
 yaUnu8cbsga6tWWkK1ZZ2jkdLyEQXnGvD35vEt+D2YeHfPGHsW66MWc0u1WOGU/lo8mHomCXw
 4lVB54fiaPJD+HsFQNiHiCvm0Erk4tH86jWpWN84A+cyseXzd2iNxi+m0T+zBlw92JOMnxJbk
 FGTzwXdrmAR5qErShr0JAVsy3RBgW8YuIuozjOeLSGuw4o8grKk6OCsz6Wop+dfXcxduo5Xx0
 mnKNp1aQWc7jQnMQcD3gfUCu2fL89iQ6U4mGhLVrOJY1prMHLCI0ZWGDoQMP3ycvYmYYzbIWU
 Eo/2w5qwxKbqb94FApZiy7MvZTqHkippZ4IToFoiWUAub1OMr0pTShFdw1ZTuYZmyKhLCTMRY
 kymb/iQ8/znL06Bbt2DhNMjo3r/leqE+KsKt5+Je7UMR9/h5fp9pp0zqQjI8bEP6RwJIEqARd
 Jqg50WxJPvq00aOPfNJHbrvdHGshUGl1arQCoJ0mfNbha2weF3M+k0KGPOMFUlBk7G0Dl87jI
 vl3deQxzDrKvC62CeyxzhNNmj4ER1HfLoB+gI2Xq/JHMqFYStw7Ag++hMCnatD5afpWf1OFcP
 0/lHUxPw+Z1YOgYdl4fJRSEhAMhm6g5BSybRKmXQDSFsBIdcExUG1Eegj4628hwdGFEgQxDul
 9xlvTi37XaThFwAqN204NW3/RG6SwzCNO8Aao4iX/gGw/i8FwgYtz0OOg0kbAxFCEXyDFpEQl
 95nyu2hL1Zw4nyfk3RqCwtjDYrlhgSHMBaeFuNH+Az2+/wjG4jlcShNB+rHropuvl8n9rnsv9
 gLGvTqAMIeCE5WJnLqxgBbVjCuzrWM84z5zzmCIKOUyx9spT4u2dSVE53PCmHBrPNP84Xa0wx
 8SmBo4sxoIv1jSBLrcb9R4I4VwQNQZJOVuDMvXfit7X9FFQQyNfEi6EhH6p8JgOlZ/Y7kO/nv
 A2cKdg+byoAGyU+Tn3F1DkPEeXhZneLdEsD1o/BFnRm0Er1E6i2nn8TLK3r4sB4jWEkaxt4eu
 LQXkIHS64ehzgcR9DULCVwUoP5iiXuSEmX6ceZ5y87+5awTv0ZkyAfNXadnwQqQHI8q3+UgfO
 4Q6IvtI0sBYWXC18nL5QkXT+uCcC4yA6bO59g8jIdo44auNV55mxuKYBm4fVso9T3imo5i/IP
 gE/Omwhna7q+fCveh65+1VEKTaSjy/3Yp0iyT1eswBBg/owNv4wOV0D5QW+dk4v+s+ixd33Nx
 BlmLyagGtJlCmDPO+cXPAQ6wh1q5sboVAqJUBNSVZMtJHSRw4RDdB578U2otyDRMD8ElPXGL+
 Mn0A4/+WlW9ulPt65/6x5i76jzdZGDo9t2cX/sCTnD4Qd+U3w4mcbhcgE605rPp9Btn/gz827
 P7WTkm75mFwuMXUwd95E6KoY8foXlZ7otJmzru7g2an495PdmIKWrn377Nz6osAro+s1g8Zpu
 2AULjj73eHdObQU1pIcApNtyuG6H57yokALfOH5lK2+aSWEYbhwSiSSyEOjco7KQyr4+R9Tsn
 lGHdvf/r/uhgo9TdSFwgzp3D/t7DTDtyeH10MQq8CEDHzHyDq8wLnht87I0VJ3HWg3Sl1eFjT
 UnDvd2ScYm077FafklZIDnk3JxOvesGWFNjDMZax060ydQMDkzO2G6ahL8kVw9uJ9L4LlUkEz
 nGxWmaB+pEtEFCnxRXfFUXJJ3ksXxwYn0VAgD3dhYr0Kjs6QXBSnftwVAszf84xfRWI7dz7vS
 OlSLK+vxNxhk+hcDo819B3WSOA6KpH09faiTOS47MNX0hZZ39+yvgxaHwD0Qh6NSM+/hNoUg2
 092zKTGwTmbTAqLF6BgksUBuSoXKwrJ5vUrwzt4Xugb2z9BDT1HfD9Xmwn4MCXklIFwa5sFZk
 /spqgOa+EGSejwLDZvxUp59aaF7yRYKOG7V3oitusAHEK3A/OG3JOMGq6Dl4m4K/j14OE+YpS
 ViuYTvWGnksihTaj3YZMvisER5/k2cpRfJGNUsUEsJ73wqFencGraU6p0Sk6ATBySaNSHIalk
 o43inuCDwHzmUAKkOAUqcawkeLHKxHi5uE8k/xdYbHBhQnJkI4yzW1NXMMJMJnh4Pnn/6Q8YT
 4n7UzE2Z4FyQd/ZAzCsyKRwA7nd0+di87Lk+WDDYn2E4nj9f5nCY623535XLgainClBR1EcvS
 OgtsypwWxGse/U94ghvUoVmRzPShKX5Gsbsm7h9kLKUONMbXKzINqH6C1+YhlpJfWySz8jbjW
 9Yh2EO5JQ6x/TyeZQC9NIgRhpoKSwIz/123hMYmoLLAMcEZoBQnA6l29I1uzY05NCN8eQxZoy
 MCtyOkl+s7S0d4S44nX70rKhtuTwf8M9dpBxYIkD8+eIwf1pnJEPIYhlT0/7hJhKsDxVT1Q9B
 kPYytin8+gBswxJOwMp5Y1N6csMuCoJ5JHTpum+L4CodIItxr3ishVkCa++e0d6pT79cVHr94
 YHWhEuChjcZnpeL29Q/s8prewhOnIVZlG9Ezj1hFM7y6ETkza2xbtmt4UMvGUXLZqEai96XXX
 6hnmlajHawuFW7ouaBjg+yRLXvWjQQBreV/PQr2upeRTgW7+Ws9hMI2JpVGIJq3bxPVWiEWA2
 rUrsYwOOY0j4omRYlW5bcqBXKwNYGiK6fZkqy/3ZZnxa8bTdn/u99mSz1I1tlmRPZyaoPRsNh
 sYZ0eIF/FN++DHULF0q5KRTkjH7uxbv6+oItgefsP6lbP3qk7qezpOzUH6CberQz26YzqmYDl
 xBHhVYfvGLFqN78xQ9uMpOOfQOs2uycZknHj002vdx3IEUDBzpYM8Ag5cCstJzJE76jsbVWGR
 H55NfmfRl3mSx+dvDC7MictByQO06SQJ8/ZGoylXetJGSYnkVO8xaCRk2OhXEK5wso/ToSS4L
 6IoDmrN/uoRnF0BQ0VuRNm1oc3D1NfGJHSEuH06T3kRwscpHPR72EV5anBIZLlvgq6mlquhVG
 Oi9NrQYqyaHKuPeq+O2FvlFBrcv+rlLocc6S79oNLzLu9XT1ABD4rGxJYdnM5ARefqzri/YP1
 vhS0UNq0W3MjITdPEoSPBISrWGAuNmNlnXr1T613HcwOTIeVCgxkAMiRh9A/QBtArIQNgbrzr
 bm0yLX7jno7HnGgUzzHFl91jR2tgRtQGuqd3PtqVZoWN9DHMkaMzRz48/PhycH0qo5aM2hOkM
 w6w9BK3Yon4Inip5jDqlUMydUbl+O3nF9CA3jod+E89ieMbkIvGNzJ1ROPGCVnZ5sZZc3Sgca
 wmXveSCqCuCKJgCTuEmTnLziQ2WdYxz5fueGlyhTZL+8SJ3DawXiNvCLz483P6oz8g2GR7k5p
 1+s+V2ylGHOJPLYCaFyg4GM+hBimOL0r4EApK/R9YiRe6YEXltDw4zt1eSeEePYwZ/dT6+Yw6
 U1vqxC9flTdcqEWw6KuU1BrjbuCgxpja78sO9FkPfCC6iJE3SXDX0PVel0OfPIW8megXCcuVg
 kgqg9zSD7hnQ8PmrvuMCiHmjQPZ8fqKkGkqlKlFLmI00kG+Z7OMhhRxl6Y3TV7n+f0bLBvBek
 z3DAgOOe85osUV/ASpyk5I34p6THPKMMUh7DM3z7Aw3qVC9swpJUqQX0vC3iuwUt9XkhYm07c
 rg8X+LIw8lNiEnSsHB1+jMSCAZU59u9vXwb//UcWHZ8nBpQihCq/uONQ74y3F2P4nlfuQWtVj
 mzdYZN+pkLVoPrDYmrgFRFdqsqsnIWVK5QflfBjn2/thrSLYmXssGZaeqf4w5O2ZHvj9BHoEl
 qp8V6xCVQsmT8FfyiQZ8mKlcjZG7jjyjrihgzen0lJIjg5LtsdvuLky2M7hnsrg2H12rC6HJ7
 abCvFCfTLbhP/mCLgGxnZhMHU9rZtVWRjc4yjlC6FSevwLYlbubGgWMiqfZ/MdB5/YqRQlAi4
 vwwQ87Y5ZEvYHNF+7eGPQ8VDONQ449DH0KQs850H52s1+3Oewn5L/0=
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, 31 Mar 2026, Paul Tarjan via GitGitGadget wrote:

> From: Paul Tarjan <github@paulisageek.com>
>=20
> When GIT_TEST_SPLIT_INDEX=3Dyes is set and the fsmonitor daemon is
> active, tweak_fsmonitor() can hit a BUG() assertion:
>=20
>   BUG: fsmonitor.c:27: fsmonitor_dirty has more entries than the index (=
2 > 0)
>=20
> The fsmonitor_dirty EWAH bitmap may reference positions from a
> previous index state.  With split-index, cache_nr can be smaller
> than the bitmap expects because entries have not been merged yet.
>=20
> This is related to the issue that 05f28e4b3c (scalar: use
> index.skipHash=3Dtrue for performance, 2025-06-04) worked around by
> disabling GIT_TEST_SPLIT_INDEX in t9210, noting "the issue should
> be resolved in a series focused on the split index."  This fixes
> the fsmonitor bitmap side; the index.skipHash interaction remains.
>=20
> Two places hit this:
>=20
>   - tweak_fsmonitor() calls assert_index_minimum() without the
>     !istate->split_index guard that the read path (line 98) and
>     write path (line 128) already have.  Add the same guard.
>=20
>   - fsmonitor_ewah_callback() unconditionally asserts and then
>     accesses istate->cache[pos], which is out of bounds with
>     split-index.  Replace the assertion with a bounds check that
>     silently skips positions beyond cache_nr.

This issue (and in particular the BUG assertion reported by the CI
failures Junio pointed at in
https://lore.kernel.org/git/xmqqjyus4qp2.fsf@gitster.g/) sounded quite
familiar to me, so I consulted my notes. I had fixed a similar symptom
after a seriously tedious debugging session via 3b7a4475b091 (split-index;
stop abusing the `base_oid` to strip the "link" extension, 2023-03-26).
But alas, this reference did not help, I found no similar bug that could
be the culprit here.

So I bisected the CI failure and it turns out that, as I suspected, this
patch addresses a symptom, not the root cause. The bug has nothing to do
with Linux FSMonitor support and this patch should be dropped from the
series. See below for a suggestion what to do instead.

The failing CI job is `linux-TEST-vars`, which is the _only_ job that sets
`GIT_TEST_SPLIT_INDEX=3Dyes`. Before this series,
`fsmonitor_ipc__is_supported()` returned 0 on Linux, so Scalar never set
`core.fsmonitor=3Dtrue`, and therefore there was never a FSMonitor bitmap =
in
the index, and the assertion in `tweak_fsmonitor()` could never fire. Now
that Linux has FSMonitor support, Scalar enables it, and the bitmap sanity
check exposes a _pre-existing_ corruption in the `index.skipHash` +
split-index interaction.

The interacting topic is `hn/git-checkout-m-with-stash` (specifically
ced477a20fa4, "checkout: -m (--merge) uses autostash when switching
branches"). That commit adds an unconditional `discard_index()` +
`repo_read_index()` cycle at the end of `switch_branches()`, even when
no autostash was created. (That is probably undesirable behavior, it
should be guarded.)

Here is the chain of events:

1. Scalar sets `index.skipHash=3Dtrue` (this is Scalar's default since
   05f28e4b3cc1 (scalar: use index.skipHash=3Dtrue for performance,
   2025-12-12)).

2. With `GIT_TEST_SPLIT_INDEX=3Dyes`, `write_locked_index()` writes a
   split index. It calls `write_shared_index()`, which calls
   `do_write_index()` for the shared index. Because `skipHash=3Dtrue`,
   the trailing hash is left as all-zeros, so `si->base->oid` is the
   null OID.

3. `write_shared_index()` then does
   (https://gitlab.com/git-scm/git/-/blob/v2.53.0/read-cache.c#L3283):

       oidcpy(&si->base_oid, &si->base->oid);

   ...copying the null OID into `base_oid`. The shared index file is
   renamed to `sharedindex.0000000000000000000000000000000000000000`.

4. The `hn/git-checkout-m-with-stash` topic's unconditional
   `discard_index()` + `repo_read_index()` re-reads the index from
   disk.

5. In `read_index_from()` (read-cache.c:2375), the condition

       if (!split_index || is_null_oid(&split_index->base_oid))

   is true, so the shared index is never loaded, `merge_base_index()`
   is never called, and we jump straight to `post_read_index_from()`.

6. This leaves `cache_nr=3D0` (all entries live in the never-loaded
   shared index), but the FSMonitor extension's `fsmonitor_dirty`
   bitmap was written against the full merged index (2 entries).

7. `tweak_fsmonitor()` (called from `post_read_index_from()`) hits:

       assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);

   and fires the BUG: `bit_size=3D2 > cache_nr=3D0`.

The same bug would reproduce on macOS or Windows if those platforms had
a TEST-vars CI job with `GIT_TEST_SPLIT_INDEX=3Dyes`.

Now, about the patch itself (reordering the hunks for clarity):

> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>  fsmonitor.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fsmonitor.c b/fsmonitor.c
> index d07dc18967..5e5a4fadea 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -805,7 +806,8 @@ void tweak_fsmonitor(struct index_state *istate)
>  			}
> =20
>  			/* Mark all previously saved entries as dirty */
> -			assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
> +			if (!istate->split_index)
> +				assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
>  			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, ista=
te);
> =20
>  			refresh_fsmonitor(istate);

This guard in `tweak_fsmonitor()` is not analogous to the guards in
`read_fsmonitor_extension()` and `write_fsmonitor_extension()`. Those
guards exist because those functions run before `merge_base_index()` has
been called. But `tweak_fsmonitor()` runs after `merge_base_index()` in
the normal read path (via `post_read_index_from()`). The fact that
`cache_nr=3D0` when `tweak_fsmonitor()` runs means the shared index was
never loaded at all, which is the real bug.

For historical context: ba1b9caca699 ("fsmonitor: delay updating state
until after split index is merged", 2017-10-27) intentionally arranged for
`tweak_fsmonitor()` to run post-merge, and 392d797e2e60 (fsmonitor: do not
check fsmonitor_dirty bits against cache entries on split index,
2019-10-31) and 7621a6f43428 (fsmonitor: do not compare bitmap size with
size of split index, 2019-11-21) added the `!istate->split_index` guard to
the read/write paths only, deliberately leaving `tweak_fsmonitor()`
unguarded because at that point the merge is expected to have happened.
cae70acf2431 (fsmonitor: de-duplicate BUG()s around dirty bits,
2021-01-23) refactored the BUG()s into `assert_index_minimum()`, again
preserving this pattern. Suppressing the assertion here would hide the
fact that the index is in a broken state.

> @@ -33,7 +33,8 @@ static void fsmonitor_ewah_callback(size_t pos, void *=
is)
>  	struct index_state *istate =3D (struct index_state *)is;
>  	struct cache_entry *ce;
> =20
> -	assert_index_minimum(istate, pos + 1);
> +	if (pos >=3D istate->cache_nr)
> +		return;
> =20
>  	ce =3D istate->cache[pos];
>  	ce->ce_flags &=3D ~CE_FSMONITOR_VALID;

This change to `fsmonitor_ewah_callback()` is particularly dangerous:
silently skipping dirty entries means files that the FSMonitor daemon
reported as changed could be treated as unchanged. That is a correctness
bug.

The proper fix belongs in one of two places:

1. `write_shared_index()` should not allow `base_oid` to become the
   null OID. When `index.skipHash=3Dtrue`, the shared index needs a real
   identifier. This is the root cause.

2. Alternatively, the `hn/git-checkout-m-with-stash` topic should
   guard its `discard_index()` + `repo_read_index()` with something
   like `if (created_autostash)`, since the index reload is only
   needed when an autostash was actually applied.

   But that would probably only buy some time until another code path
   introduces a similar pattern, and maybe shouldn't even be considered a
   real fix.

Alternatively, I'd suggest:

3. The same work-around as was introduced in 05f28e4b3cc1 (scalar: use
   index.skipHash=3Dtrue for performance, 2025-12-12), namely to simply
   force-disable split index in the offending test case (or move the
   existing `sane_unset` to the top of the file, since
   `index.skipHash=3Dtrue` is a Scalar thing):

  -- snip --
  diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
  index 009437a5f316..a4e38ad644e4 100755
  --- a/t/t9210-scalar.sh
  +++ b/t/t9210-scalar.sh
  @@ -152,6 +152,11 @@ test_expect_success 'set up repository to clone' '
   '
  =20
   test_expect_success 'scalar clone' '
  +	# The split index refers to the base index via OID; Scalar sets
  +	# index.skipHash, though, and therefore that OID is always bogus;
  +	# Scalar/index.skipHash are simply incompatible with split-index
  +	sane_unset GIT_TEST_SPLIT_INDEX &&
  +
   	second=3D$(git rev-parse --verify second:second.t) &&
   	scalar clone "file://$(pwd)" cloned --single-branch &&
   	(
  -- snap --

Either way, this 13/13 patch should be dropped from the fsmonitor-linux
series, I think.

Ciao,
Johannes
