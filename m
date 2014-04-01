From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: fast-import deltas
Date: Tue, 1 Apr 2014 10:38:56 -0700
Message-ID: <20140401173856.GC6851@google.com>
References: <20140401102554.GA32231@glandium.org>
 <20140401114502.GA15549@sigill.intra.peff.net>
 <20140401130703.GA1479@glandium.org>
 <20140401131512.GA19321@sigill.intra.peff.net>
 <20140401141856.GA2497@glandium.org>
 <xmqqk3b90y79.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 19:39:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV2eR-0005FP-BY
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 19:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbaDARjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 13:39:01 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:57622 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaDARjA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 13:39:00 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so9866805pdj.31
        for <git@vger.kernel.org>; Tue, 01 Apr 2014 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ka3AB1SPj+r7DnqVnJZ03Qa4DbuYdDi2q1cuhU+/BJ4=;
        b=F8NFIS4jqpkxhNiwfoXCnp6ZzRjPW1AjPpp7S+LSiGwWEBNpkbQnlBwjc5Rg3/+fIk
         PctkJyHW/l/wtymFMQ66zZ6aQufNFCf4TSh55GoKAeYuVOwdEHEKYQU9LOlNfTGU2ENr
         rDBZ6k0Ah3RtSPBXfWMnECuStEGLr8duMqatTZZUCkGVVyF11Wlb2HCg/qrptFMp7mYm
         duvkCvSR6CtgXvBOMHkDBFeBa+NZGvji8tNrR2IBntH7WPwL3Fe/xXIqTfoWuu56+qVN
         cyYJCCoQSmmP0rFHfVB09GATTlgs904bAtl25I9j9mKnkXchdFRKRNsyaF3GMM0syNRw
         TR9A==
X-Received: by 10.66.193.161 with SMTP id hp1mr32623436pac.20.1396373939659;
        Tue, 01 Apr 2014 10:38:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vo1sm58912212pab.32.2014.04.01.10.38.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Apr 2014 10:38:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqk3b90y79.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245617>

Junio C Hamano wrote:

> Assuming that you do have and are willing to read the original file,
> you have three possible (and one impractical) approaches:
[...]
>  - Apply the foreign changes to the original file yourself, and feed
>    the resulting content to fast-import in full, letting fast-import
>    convert into the format Git understands.

This (when importing from Subversion) was the motivation for
introducing fast-import's cat-blob command, for what it's worth.

[...]
> In short, the most practical solution would be to reconstitute a
> full object and feed that to fast-import, unless you already have
> xdelta or you can turn your foreign change into xdelta without ever
> looking at the original.

If your delta format happens to be similar enough to xdelta, then
streaming in deltas in xdelta format does sound like a neat trick.

Maybe it would be useful to provide a micro-library that creates and
validates xdelta opcodes for fast-import frontends to use.

Jonathan
