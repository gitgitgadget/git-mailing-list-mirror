From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT PATCH 00/20] PackWriter, first usable attempt
Date: Mon, 16 Jun 2008 18:37:18 +0200
Message-ID: <485696BE.4010608@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com> <20080616051927.GV11793@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 18:38:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Hil-0000e0-Sb
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 18:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbYFPQhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 12:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754195AbYFPQhY
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 12:37:24 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:50873 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081AbYFPQhY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 12:37:24 -0400
Received: by an-out-0708.google.com with SMTP id d40so1214003and.103
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6wF3/ASBB+hyB7hqLI53gYPnNZmnso7Drstfawy2v+w=;
        b=Hd1BjPPAQ5P65JkwX/VPcdQJLapn12OTYASpZe2gGBNpR1DyDNKL6xAxVJW7uyfk9V
         kVp+MfLoFrWFBv2tVtdUaiF8vLGZENNsa//6IeKMBzoAbWGhBNSlqJuceAI2J+h3hudb
         PvhxZpK6cMun2eWN/w52TE0Zp8T1wLdYxGg1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=aI8CNjSkIhAHrVZuv7EhQDX6drKnr2K8J/g3J27GvNqfHm4/qgYQrZBPj92/04scB3
         KlfV0YhpGkgc+a8GVWdDFBQBYIQJcdeE16K3mVb3m4RDNudGsclg6xil8oCqUqi/cI8z
         drH/t9L7e6o91NidYdb0H6GmC1vKPCrqCHh2Q=
Received: by 10.100.173.9 with SMTP id v9mr4816398ane.92.1213634242868;
        Mon, 16 Jun 2008 09:37:22 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id k29sm444679qba.7.2008.06.16.09.37.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 09:37:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080313 Iceape/1.1.9 (Debian-1.1.9-5)
In-Reply-To: <20080616051927.GV11793@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85207>

Shawn O. Pearce wrote:
> Marek Zawirski <marek.zawirski@gmail.com> wrote:
>> At first, some stuff was still missing to produce packs, mostly
>> raw-data access related and ObjectWalk related.
> 
> I'm glad it turned out to be so little missing actually.  Reusing
> ObjectWalk saved a lot of code in the pack writer, and for the most
> part our existing data access structures were already well organized.

Yeah, I actually expected that this feature implementation would cause 
more changes. But existence of transport and rev-walking frameworks in 
jgit helped a lot. Jgit code changed significantly between my first look 
at it (march/april) and GSoC start date.

(...)
>> Finally, we've got some support for pack writing! It's not that
>> power that C git version offers, but something usable. Delta
>> generation is not supported. Although we can reuse deltas and objects,
>> and support all other (I hope) options of git-pack-objects directly or
>> indirectly, most importantly --thin.
>>
>> Pack writing and some other features are tested, seem to work.
>>
>> This implementation of packing is not a very valuable thing directly
>> (achieving efficient storage), however it's a base for enhancements
>> and can be used for sending packs over net (with some assumptions).
>> It's more a "repacking" than "packing" tool.
> 
> Yup.  The critical part here is jgit can now format a pack file,
> which means we can now actually implement native push over the
> local pipe (to fork+exec'd git-receive-pack) or over SSH.  That
> is one of the major missing features in the Eclipse plugin, so
> this is a huge milestone for us.  Thank you Marek.

Hey, I'm here for doing this, they even pay me for that fun;)

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
