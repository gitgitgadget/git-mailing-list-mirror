From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Fri, 14 Mar 2014 19:37:28 +0700
Message-ID: <CACsJy8AZ0CfqHRYDrnQD+z0ibVQnsFuSzktEHKRhCVwaXPQryg@mail.gmail.com>
References: <5110DF1D.8010505@alum.mit.edu> <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org> <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org> <CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
 <20140311014945.GB12033@sigill.intra.peff.net> <xmqqtxb4pm3u.fsf@gitster.dls.corp.google.com>
 <20140311200513.GB29102@sigill.intra.peff.net> <xmqq4n34pjnw.fsf@gitster.dls.corp.google.com>
 <20140311203650.GA31173@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 13:38:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WORNG-0008Sh-LJ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 13:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbaCNMiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 08:38:00 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:35273 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108AbaCNMh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 08:37:59 -0400
Received: by mail-qc0-f170.google.com with SMTP id e9so2813486qcy.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=El12MmQLgqU/E52BWrocKUu0MeU9jxZ761FZCcYJUg0=;
        b=RczCDl7ulnegHl6T5K11hrk4B62Um4vOQiFemOBHMPII2vLvrNB9RwTpejsPA7YbtX
         VTbbHeRwOTe/IKoix8aMlIMfIhMeu1kU+n7uwwPvdlI2D6w8LtA/FxUyiEAq6ge4RwUK
         I+CdXxZRbkcjKVcmQGes6YdJ5FrrbUeVWF7HgwPnGVqfLdOtxTIX/rFXRgxV3S6AqAp5
         50cvah7P6UB2o8eI883TQzuyS0ZO17YQgkydEtP5m4J+DPCHCVqPWnL2+Ee/VvLg3a9p
         BmwIwihz4fUGYmegzI79Vh5hnlCp4HvhL1eJLx0+VLyEtsWMfpyhSgsaToixWBtsf2eU
         GAoA==
X-Received: by 10.140.40.5 with SMTP id w5mr8791470qgw.65.1394800679016; Fri,
 14 Mar 2014 05:37:59 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Fri, 14 Mar 2014 05:37:28 -0700 (PDT)
In-Reply-To: <20140311203650.GA31173@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244087>

On Wed, Mar 12, 2014 at 3:36 AM, Jeff King <peff@peff.net> wrote:
> If the client is limited to setting a few flags, then something like
> http can get away with:
>
>   GET foo.git/info/refs?service=git-upload-pack&advertise-symrefs&refspec=refs/heads/*
>
> And it does not need to worry about upload-pack2 at all. Either the
> server recognizes and acts on them, or it ignores them.
>
> But given that we do not have such a magic out-of-band method for
> passing values over ssh and git, maybe it is not worth worrying about.

git could go the same if we lift the restriction in 73bb33a (daemon:
Strictly parse the "extra arg" part of the command - 2009-06-04). It's
been five years. Old daemons hopefully have all died out by now. For
ssh, I suppose upload-pack and receive-pack can take an extra argument
like "advertise-symrefs&refspec=refs/heads/*" (daemon would use it too
to pass the advertiment to upload-pack and receive-pack).

That would make all three not need to change the underlying protocol
for capability advertisement. Old git-daemon, upload-pack and
receive-pack will fail hard on the new advertisement though, unlike
http. But that's no worse than upload-pack2.

> Http can move to upload-pack2 along with the rest.

Or maybe http may lead the rest to another way.
-- 
Duy
