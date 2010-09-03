From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [BUG?] rename patch accepted with --dry-run, rejected without (Re:
 [PATCH V3] arm & sh: factorised duplicated clkdev.c)
Date: Fri, 3 Sep 2010 13:43:51 -0500
Message-ID: <20100903184351.GC2341@burratino>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
 <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
 <AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
 <20100903182323.GA17152@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Magnus Damm <magnus.damm@gmail.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
	git@vger.kernel.org, bug-patch@gnu.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: linux-sh-owner@vger.kernel.org Fri Sep 03 20:45:45 2010
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-sh-owner@vger.kernel.org>)
	id 1OrbGi-0006sk-V8
	for glps-linuxsh-dev@lo.gmane.org; Fri, 03 Sep 2010 20:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936Ab0ICSpn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glps-linuxsh-dev@m.gmane.org>);
	Fri, 3 Sep 2010 14:45:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42740 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915Ab0ICSpn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sh@vger.kernel.org>); Fri, 3 Sep 2010 14:45:43 -0400
Received: by fxm13 with SMTP id 13so1376906fxm.19
        for <multiple recipients>; Fri, 03 Sep 2010 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iMieZydjl9UaGqGjgBUkUBOVmiT2rFgehbvT0Zufig8=;
        b=v6dTb+UdB8qZBmam38BCUq6Y5QxTPfdjPywYK0LUN3aT/RTq5xyW3XE/zjqmEe2Obe
         46pzswRLQ3k25oQTF0a557NvG+fVRDkG1rq4go0rs3V3Z9HSAWvw5a4kJxio2MDsQCz+
         DyNSIsrqWI7XmxLuDsDpeXLGdpcrpZ8XEV+8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=iyLO/nlELnWxaQVFQGlsH79sd7JxwB56DEroBjWYg4kVoVRtpHJcsAHPOWTQkidWOb
         zAt6MC1+Yemlh6UFLm9z7RDUg/wriiFA5BWXVg+r7FVGe/yg29Ex1qpE2t54E2T2gmwa
         1jSwVwHbYxxzgCna6XEgUCxodsrD3cYcO0J48=
Received: by 10.103.191.20 with SMTP id t20mr218872mup.35.1283539541459;
        Fri, 03 Sep 2010 11:45:41 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id a16sm896827vcm.18.2010.09.03.11.45.39
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 11:45:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100903182323.GA17152@pengutronix.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155262>

(+cc: bug-patch)

Hi,

Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:

>> Using --dry-run is fine, but omitting dry-run gives me:
>>=20
>> ...
>> patching file arch/arm/common/clkdev.c
>> patching file arch/sh/include/asm/clkdev.h
>> Hunk #1 FAILED at 1.
>> Hunk #2 FAILED at 11.
>> 2 out of 2 hunks FAILED -- saving rejects to file
>> arch/sh/include/asm/clkdev.h.rej
>>=20
>> I guess this is caused by the last "renaming" hunk, see below.

Yep, I can reproduce this.  Patch applies with "git apply",
"patch --dry-run -p1" accepts it, "patch -p1" fails.

 $ patch --version | head -1
 GNU patch 2.6.1.85-423d
 $ cd ~/src/linux-2.6
 $ git checkout 2bfc96a12
 $ git clean -fd
 $ wget http://download.gmane.org/gmane.linux.ports.sh.devel/8747/8748
 $ patch -p1 --quiet --dry-run <8748=20
 $ echo $?
 0
 $ patch -p1 --quiet <8748=20
 2 out of 2 hunks FAILED -- saving rejects to file include/linux/clkdev=
=2Eh.rej
 $ echo $?
 1

Andreas: ideas?
