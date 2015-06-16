From: Augie Fackler <augie@google.com>
Subject: Re: [PATCH 3/3] pkt-line: support tracing verbatim pack contents
Date: Tue, 16 Jun 2015 12:52:46 -0400
Message-ID: <CAHcr6HbKfE=B502t9hJt601-mco+PK9s4uViFW3AkHABubiF0w@mail.gmail.com>
References: <20150612212526.GA25447@peff.net>
	<20150612212827.GC25757@peff.net>
	<CAHcr6HYvVR4uTmtegWHK0h+v_aVs4JVLsSwvjthGY3pb=-Q0yQ@mail.gmail.com>
	<xmqqvben6214.fsf@gitster.dls.corp.google.com>
	<20150616164310.GA18667@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 18:52:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4u6W-0002rD-Se
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 18:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbbFPQwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 12:52:49 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35463 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbbFPQwr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 12:52:47 -0400
Received: by wgbhy7 with SMTP id hy7so16834273wgb.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 09:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GinPQEJW5r7AV1/bVoK0zzY/pAow1QhvBWiyq4pHEdY=;
        b=Utsn/qyXb2F/Zsl7JgfkudRxYtzVRdUj+gctsycjJoIGrj8Lcc9XqJp93UnHVaXhBK
         rQqUx/Q8EJD5ux5OILcs0hm6wSqK/Z54FsttYZdY0oZ5XvI70/OslPKkyMUz/UZEoS1f
         xrUbO0ajPuuvMUcj1zGZ+ZIw8l9AVitvRLUlR5TVKLSZ7VZ9jIGPbhCUa9jc4UE4ciDf
         jTyFhULzp0Q444Zn+Bu3d2zwl7K0W27KhC/Mm4reOlU+V1iT95BD4czp7KnG4Z7YhsOI
         0PZE/kntBhzns3N+mKM3ow2cxed1fZ4pkGwt3Jo5PuZU2ssaPRs0gWzwy/jAkyel4Yzs
         L1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GinPQEJW5r7AV1/bVoK0zzY/pAow1QhvBWiyq4pHEdY=;
        b=Vyk4oMmplLg1mTslb+pZ9VfG0C+aMWGvIXKDrmiI8QsGQrQZU/pxPLCq2ZYcoxCl/F
         B05HNecbVMmWM6/aibmWbo0AFU8LFNAlqU6XQjAy7kBiDRIMc+VmL7g0hTg6GLuLCs39
         SuFZ7kesfcyz0jiBmwazzM3zL7iyzY63Z6/4C52UWjWYrtTPgur14pA18xWa1xkS2+ta
         0V4/BCzgrlzpIP55f+1t/snqOQRueK3Onri0A3sjUvnspdH6bUSdJlRiLlTkK8RzxGl4
         Xvg2mRjuf2pJ43eyEMNnbl92HTXckN138ksogv+BrVeG1NawOVRo0SIY/P5W1Fjn3whY
         K6wA==
X-Gm-Message-State: ALoCoQl/Ck+GwC95LbgAxQrtco2v40nFess56/eRJjzPpiEsNqs/GtPevHgjHCFTYsLudPoJlIFK
X-Received: by 10.180.94.106 with SMTP id db10mr44274903wib.1.1434473566426;
 Tue, 16 Jun 2015 09:52:46 -0700 (PDT)
Received: by 10.28.146.143 with HTTP; Tue, 16 Jun 2015 09:52:46 -0700 (PDT)
In-Reply-To: <20150616164310.GA18667@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271779>

On Tue, Jun 16, 2015 at 12:43 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 16, 2015 at 09:39:19AM -0700, Junio C Hamano wrote:
>
>> As to the documentation, I have a feeling that, unless the reader
>> and/or the user intimately knows that TRACE_PACK is implemented by
>> hooking into the same mechanism that TRACE_PACKET needs to, s/he
>> would not even wonder if TRACE_PACKET needs to be enabled when
>> asking for TRACE_PACK.  Yes, one is a proper substring of the other,
>> but the similarity between the two stops there.  While I do not
>> think it would hurt very much to mention that they are independent,
>> I have a slight suspicion that it might make it more likely to get
>> user confused.
>
> Yes, I was just re-reading the documentation based on Augie's comment,
> and it seems pretty clear to me. Of course I wrote it, so that is not
> saying much. Augie, I'd be happy to hear a proposed wording change if
> you have one.

Yeah, I don't have one - I may have been making assumptions because I
knew something of the background on your implementation. i'd say let
it live and if people provide feedback later figure out a reword
(writing for humans is not a strong suit of mine, alas.)

>
> I do kind of hate the name TRACE_PACK for two reasons:
>
>   - it _is_ so close to TRACE_PACKET; maybe TRACE_PACKFILE would be
>     better

+1 on TRACE_PACKFILE - also makes it harder to accidentally leave off
the ET and get binary spew when one didn't expect that.

AF
