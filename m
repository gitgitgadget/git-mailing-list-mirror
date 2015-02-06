From: Jeff King <peff@peff.net>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] cpu: add device_add foo-x86_64-cpu
 support
Date: Fri, 6 Feb 2015 14:33:49 -0500
Message-ID: <20150206193349.GB4220@peff.net>
References: <cover.1421214154.git.zhugh.fnst@cn.fujitsu.com>
 <20150205114914.GA10126@stefanha-thinkpad.redhat.com>
 <54D38B73.4060803@redhat.com>
 <xmqqiofgkvi4.fsf@gitster.dls.corp.google.com>
 <20150205195758.GC15326@peff.net>
 <xmqq61bgkt9w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Blake <eblake@redhat.com>,
	Stefan Hajnoczi <stefanha@gmail.com>,
	Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org,
	tangchen@cn.fujitsu.com, chen.fan.fnst@cn.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, imammedo@redhat.com,
	guz.fnst@cn.fujitsu.com, anshul.makkar@profitbricks.com,
	afaerber@suse.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 20:33:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJof6-0002lv-NI
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 20:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbbBFTdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 14:33:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:46058 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752144AbbBFTdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 14:33:52 -0500
Received: (qmail 3613 invoked by uid 102); 6 Feb 2015 19:33:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Feb 2015 13:33:52 -0600
Received: (qmail 11086 invoked by uid 107); 6 Feb 2015 19:33:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Feb 2015 14:33:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2015 14:33:49 -0500
Content-Disposition: inline
In-Reply-To: <xmqq61bgkt9w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263419>

On Thu, Feb 05, 2015 at 12:17:15PM -0800, Junio C Hamano wrote:

> > Would "length() > 1" be enough[1]? Or are people really typing "yes" and
> > not just "y"?
> >
> > I cannot imagine a charset name that is smaller than two characters. It
> > may be that there are none smaller than 4, and we could cut it off
> > there. Googling around for some lists of common charsets, it seems like
> > that might be plausible (but not any larger; "big5" is 4 characters, and
> > people may spell "utf8" without the hyphen).
> >
> > -Peff
> >
> > [1] Of course, to match the existing regex code, we may want to spell
> >     this as "/../" or "/..../".
> 
> Perhaps. Just in case there were shorter ones, something like this
> with confirm_only to allow them to say "Yes, I do mean 'xx'"?
> 
>  git-send-email.perl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 3092ab3..848f176 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -752,6 +752,7 @@ sub file_declares_8bit_cte {
>  		print "    $f\n";
>  	}
>  	$auto_8bit_encoding = ask("Which 8bit encoding should I declare [UTF-8]? ",
> +				  valid_re => qr/.{4}/, confirm_only => 1,
>  				  default => "UTF-8");
>  }

Yes, I think leaving an escape hatch is a good idea, just in case.

-Peff
