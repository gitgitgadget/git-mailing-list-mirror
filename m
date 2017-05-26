Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1791FA14
	for <e@80x24.org>; Sat, 27 May 2017 01:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756333AbdE0BLr (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 21:11:47 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:15848 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948725AbdEZVRO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 17:17:14 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id EMbfdx9DxcpskEMbfd0y5D; Fri, 26 May 2017 22:17:12 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8
 a=PKzvZo6CAAAA:8 a=NEAV23lmAAAA:8 a=lOJyOL6uZ2HecSn7wkMA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22 a=q92HNjYiIAC_jH7JDaYf:22
Message-ID: <FC1CD6DCF3C541CD90DAD51559E1CB64@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
Cc:     =?UTF-8?Q?F=C3=A9lix_Saparelli?= <felix@passcod.name>,
        <git@vger.kernel.org>
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com> <xmqqa864mea3.fsf@gitster.mtv.corp.google.com> <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley> <20170524141947.2gguzcvyu6lch373@sigill.intra.peff.net> <xmqqshjtg1kh.fsf@gitster.mtv.corp.google.com> <xmqqa861fx34.fsf@gitster.mtv.corp.google.com> <20170525155924.hk5jskennph6tta3@sigill.intra.peff.net> <20170525191115.tqd6zlj5mxqls4wp@sigill.intra.peff.net> <CEF93B59EA3F49608B41892952454B1D@PhilipOakley>
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch tries to check out the master branch
Date:   Fri, 26 May 2017 22:17:11 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfG+5zCiZNYyRPZNk3Br9chTXHtgZaEg8e2Ce2MdtUA79gIFAJBVZ9BkWctr78Mu9fatbFZ0L2zXX08+7rY8vyc+SQ/5oqGMnMOHB4m2GZ68xorjKcAAj
 /zRRCLrV0hLeatwFxu2mB/4eIz58F/EIDnWjIB9BvBbAF7Z3FbrxqpBHd+P1IJRaQR9LC4e2yZERt6G7fxTga/jYxzuKjS6pF4BUVTTZyXIntRgob3tEAfbt
 n0rbxcv+8h34tJYlD4Prgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

adding and updating an example..
From: "Philip Oakley" <philipoakley@iee.org>
> been trying to keep up...
>
> From: "Jeff King" <peff@peff.net>
>> On Thu, May 25, 2017 at 11:59:24AM -0400, Jeff King wrote:
>>
>>> The just-HEAD case could look like:
>>
>> This patch does work, in the sense that upload-pack advertises the
>> unborn HEAD symref. But the client doesn't actually do anything with it.
>> The capability parsing happens in get_remote_heads(), which passes the
>> data out by adding an annotation to the "struct ref" list. But of course
>> we have no HEAD ref to annotate.
>>
>> So either get_remote_heads() would have to start returning a bogus HEAD
>> ref (with a null sha1, I guess, which all callers would have to
>> recognize). Or clone (and probably "remote set-head -a") would have to
>> start reaching across the transport-module boundary and asking for any
>> symref values for "HEAD". I'm not excited about more special-casing of
>> "HEAD", though. In theory we'd want this for other symrefs in the long
>> run, and it would be nice if clients were ready to handle that (even if
>> the protocol isn't quite there).
>>
>> I dunno. I was thinking there might be a quick tweak, but I'm wondering
>> if this arcane case is worth the restructuring we'd have to do to
>> support it. It only comes up when you've moved the server repo's HEAD to
>> an unborn branch _and_ you have other refs (since otherwise we don't
>> even send capabilities at all!).
>>
>> -Peff
>
> My original comment regarding Felix's report was based on when I was 
> looking at the bundle code's disambiguation of refs which matched HEAD's 
> sha1. Hence I had a mis-remembered impression that the HEAD - symref 
> matching was avaibable.
>
> At that time, Junio had suggested that, at least in the bundle file, the 
> HEAD symref could be advertised immediately after a nul on the ref line.
>
> At least for regular git, the sha1and symref value would included in the 
> read line, and the current string processing [1] would not notice the 
> extra symref data. This extra data could then be read (if present) from 
> the end of the line, and the HEAD symref set.
>
> What I then noticed (but didn't report to the list) was the option of 
> adding that extra info to the PKLINE protocol.
>
> <from my notes>
> In technical\pack-protocol.txt #L136;158-160
> Reference Discovery:
>
> If HEAD is a valid ref, HEAD MUST appear as the first advertised
> ref.  If HEAD is not a valid ref, HEAD MUST NOT appear in the
> advertisement list at all, but other refs may still appear.
> -
>
> So, (for both upload pack, and bundle refs) the place to hide the HEAD is 
> after the later ref that HEAD points to.
> e.g.(updating the example at #L147):
>   00441d3fcd5ced445d1abc402225c0b8a1299641f497 
> refs/heads/integration\0HEAD[LF]
>
> The potential issue is if there is a passed ref that is HEAD, but that 
> HEAD itself isn't passed (especially for bundle)
> <\from my notes>
> --
>
> However given the discussion about an unborn HEAD, the option here would 
> be to also pass the NULL sha for the symref and then add the annotation 
> 'HEAD' after an extra \0, in the same way that an active symref could be 
> annotated with the '\0HEAD'. This would kill two birds with one stone!
>
> These are still protocol changes but should squeeze into the existing 
> processing using the \0 trick.
>
> In the absence of the information, and the multi-use of the warning 
> function, the current message is possible the best we can get.
>
> Philip
>
> [1] the question would be whether other git versions also use the same 
> string processing so could be 'fooled' in the same way? I'd be interested 
> to know if that was a possibility.
>
Updating the original example with the suggestion of adding the unborn ref 
and a \0HEAD marker (sort order may be an issue if it is the first entry 
which 'clashes' with the capability string... - I've been lenient here)

  $ git ls-remote git://github.com/passcod/UPPERCASE-NPM.git
  efc7dbfd6ca155d5d19ce67eb98603896062f35a refs/heads/MASTER
  0000000000000000000000000000000000000000 refs/heads/master\0HEAD
  e60ea8e6ec45ec45ff44ac8939cb4105b16477da refs/pull/1/head
  f35a73dcb151d336dc3d30c9a2c7423ecdb7bd1c refs/pull/2/head
  0d9b3a1268ff39350e04a7183af0add912b686e6 refs/tags/V1.0.0
  efc7dbfd6ca155d5d19ce67eb98603896062f35a refs/tags/V1.0.1

--
Philip

