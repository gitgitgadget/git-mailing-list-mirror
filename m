From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] sequencer: Expose API to cherry-picking machinery
Date: Thu, 11 Aug 2011 16:56:50 -0500
Message-ID: <20110811215650.GA13839@elie.gateway.2wire.net>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 23:57:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrdFO-0004CI-My
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 23:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab1HKV46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 17:56:58 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52566 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab1HKV45 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 17:56:57 -0400
Received: by yxj19 with SMTP id 19so1621120yxj.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 14:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=T4Agh4rxPqA4qa5uT/H5w4Tgjim6RAH28Hj+f0CQGGU=;
        b=kkOMfoTpR9mgMR6OWUSdghpBfHPro6kAPZ8WebLC2E1fQkwdbgbXcDc7AMKnTLW56N
         AlFtmQ4fXRv4038xnGn6LWvokAwHWykU9NpOd25GbvYvmTN8Uxsjwemw3vj29yVPfnPl
         rNA4Ps7jUtXK8e5scp54zsuaSG1MFv8Xbldmg=
Received: by 10.150.131.14 with SMTP id e14mr1288660ybd.38.1313099817139;
        Thu, 11 Aug 2011 14:56:57 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.sbcglobal.net [69.209.69.68])
        by mx.google.com with ESMTPS id g69sm267951yhk.30.2011.08.11.14.56.55
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 14:56:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313088705-32222-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179146>

Ramkumar Ramachandra wrote:

> +++ b/sequencer.c
> @@ -1,8 +1,809 @@
[...]
> +static const char * const revert_usage[] = {
> +	"git revert [options] <commit-ish>",
> +	"git revert <subcommand>",
> +	NULL
> +};
[...]
> +++ b/sequencer.h
[...]
> @@ -25,4 +50,7 @@ struct replay_insn_list {
>   */
>  void remove_sequencer_state(int aggressive);
>
> +void sequencer_parse_args(int argc, const char **argv, struct replay_opts *opts);

Another thought.  I wonder if it's possible to leave
sequencer_parse_args() private to builtin/revert.c, making the split
a little more logical:

 - the builtin takes responsibility for its commandline interface
 - the library takes over once the builtin has figured out what the
   user wanted.

(If another command wants to reuse some subset of cherry-pick/revert's
commandline options, an appropriate function can always be exposed
later.)
