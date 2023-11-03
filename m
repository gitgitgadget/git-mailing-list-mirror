Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA61A585
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8DE1B2
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 08:01:14 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 3A3Ew4wG4190594
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 3 Nov 2023 14:58:04 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
References: <007101da0e65$13e3c170$3bab4450$@nexbridge.com>
In-Reply-To: <007101da0e65$13e3c170$3bab4450$@nexbridge.com>
Subject: RE: [BUG] Git 2.43.0-rc0 - t4216 unpack(Q) invalid type
Date: Fri, 3 Nov 2023 11:01:08 -0400
Organization: Nexbridge Inc.
Message-ID: <007501da0e66$96f124d0$c4d36e70$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFgCjSkAWxdBsLhuAAZh2QhpI04hbFctoPQ
Content-Language: en-ca

On Friday, November 3, 2023 10:50 AM, I wrote:
>In RC0, the following tests are failing (with verbose). They look like the
same root
>cause. Unpack("Q>".... What version does git now require for perl?
>I have v5.30.3 available, nothing more recent.
>
>expecting success of 4216.141 'Bloom reader notices too-small data chunk':
>check_corrupt_graph BDAT clear 00000000 && echo "warning: ignoring
too-small
>changed-path chunk" \
>"(4 < 12) in commit-graph file" >expect.err && test_cmp expect.err err
>
>Invalid type 'Q' in unpack at
>/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/t/lib-chunk/corrupt-chun
k
>-file.pl line 31.
>not ok 141 - Bloom reader notices too-small data chunk #
#check_corrupt_graph
>BDAT clear 00000000 && #echo "warning: ignoring too-small changed-path
chunk"
>\
>#"(4 < 12) in commit-graph file" >expect.err && #test_cmp expect.err err #
>
>expecting success of 4216.142 'Bloom reader notices out-of-bounds filter
>offsets':
>check_corrupt_graph BIDX 12 FFFFFFFF &&
># use grep to avoid depending on exact chunk size grep "warning: ignoring
out-of-
>range offset (4294967295) for changed-path filter at pos 3 of
>.git/objects/info/commit-graph" err
>
>Invalid type 'Q' in unpack at
>/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/t/lib-chunk/corrupt-chun
k
>-file.pl line 31.
>not ok 142 - Bloom reader notices out-of-bounds filter offsets #
>#check_corrupt_graph BIDX 12 FFFFFFFF && ## use grep to avoid depending on
>exact chunk size #grep "warning: ignoring out-of-range offset (4294967295)
for
>changed-path filter at pos 3 of .git/objects/info/commit-graph" err #
>
>expecting success of 4216.143 'Bloom reader notices too-small index chunk':
># replace the index with a single entry, making most # lookups
out-of-bounds
>check_corrupt_graph BIDX clear 00000000 && echo "warning: commit-graph
>changed-path index chunk" \ "is too small" >expect.err && test_cmp
expect.err err
>
>Invalid type 'Q' in unpack at
>/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/t/lib-chunk/corrupt-chun
k
>-file.pl line 31.
>not ok 143 - Bloom reader notices too-small index chunk # ## replace the
index with
>a single entry, making most ## lookups out-of-bounds #check_corrupt_graph
BIDX
>clear 00000000 && #echo "warning: commit-graph changed-path index chunk" \
>#"is too small" >expect.err && #test_cmp expect.err err #
>
>expecting success of 4216.144 'Bloom reader notices out-of-order index
>offsets':
># we do not know any real offsets, but we can pick # something plausible;
we
>should not get to the point of # actually reading from the bogus offsets
anyway.
>corrupt_graph BIDX 4 0000000c00000005 && echo "warning: ignoring decreasing
>changed-path index offsets" \
>"(12 > 5) for positions 1 and 2 of .git/objects/info/commit-graph"
>>expect.err &&
>git -c core.commitGraph=false log -- A/B/file2 >expect.out && git -c
>core.commitGraph=true log -- A/B/file2 >out 2>err && test_cmp expect.out
out &&
>test_cmp expect.err err
>
>Invalid type 'Q' in unpack at
>/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/t/lib-chunk/corrupt-chun
k
>-file.pl line 31.
>not ok 144 - Bloom reader notices out-of-order index offsets # ## we do not
know
>any real offsets, but we can pick ## something plausible; we should not get
to the
>point of ## actually reading from the bogus offsets anyway.
>#corrupt_graph BIDX 4 0000000c00000005 && #echo "warning: ignoring
>decreasing changed-path index offsets" \
>#"(12 > 5) for positions 1 and 2 of .git/objects/info/commit-graph"
>>expect.err &&
>#git -c core.commitGraph=false log -- A/B/file2 >expect.out && #git -c
>core.commitGraph=true log -- A/B/file2 >out 2>err && #test_cmp expect.out
out
>&& #test_cmp expect.err err #
>

This same problem also happens in t5318, t5319, t5324
--Randall

