From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v7 4/5] pretty: Add failing tests: --format output should
 honor logOutputEncoding
Date: Thu, 4 Jul 2013 00:20:15 +0400
Message-ID: <20130703202015.GB32573@dell-note>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com>
 <9e83de68067be7548c0119d6e99caa905fab0c0f.1372240999.git.Alex.Crezoff@gmail.com>
 <51D12927.5050000@viscovery.net>
 <20130701225013.GA17377@ashu.dyn1.rarus.ru>
 <51D27FA1.9040600@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 03 22:20:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuTXi-0000nL-9p
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 22:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978Ab3GCUUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 16:20:22 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36297 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964919Ab3GCUUT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 16:20:19 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so574521lbi.40
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 13:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Fj8WrQf8Zt+A962zNSuxxs8mhDZQkuToEs2oGPA3DTk=;
        b=JXyeVEQN+qzTSPZwQmsIU9Wksy4wI3MDQ6TzkA0nhxn4jmrBwvQf/6tHxmKggnvGFm
         UpJTnG/U0WNRe6FrFJwaHhrulU06eaZ8vgixH4cfwIran5O1+faNLM8n47GcnexpDk/B
         hlWGYd2osDbybB20nCrjCmkFSk8hV9det2O4zE3gNnIQIJ8Hvxu9S+3AJITH1lenqNJV
         09dukM9DIKdirgsOl2UmGqnhBL7u4tImU9prtkGtvbikeDCzY33nPs7v3Y97Ok+zeI+Y
         CEzCEj9RpdJoaktdCdLlDI5mQ10qo0N1iuVJco8n+K/TW2JrR+zgRD1bNiyvJaTDI17H
         lzTw==
X-Received: by 10.112.50.77 with SMTP id a13mr1992021lbo.46.1372882817947;
        Wed, 03 Jul 2013 13:20:17 -0700 (PDT)
Received: from localhost (ppp91-77-20-80.pppoe.mtu-net.ru. [91.77.20.80])
        by mx.google.com with ESMTPSA id t15sm68152lbh.16.2013.07.03.13.20.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 13:20:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51D27FA1.9040600@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229523>

On Tue, Jul 02, 2013 at 09:22:09AM +0200, Johannes Sixt wrote:
> Am 7/2/2013 0:50, schrieb Alexey Shumkin:
> > On Mon, Jul 01, 2013 at 09:00:55AM +0200, Johannes Sixt wrote:
> >> Am 6/26/2013 12:19, schrieb Alexey Shumkin:
> >>>  test_expect_success 'setup complex body' '
> >>>  	git config i18n.commitencoding iso8859-1 &&
> >>>  	echo change2 >foo && git commit -a -F commit-msg &&
> >>>  	head3=$(git rev-parse --verify HEAD) &&
> >>> -	head3_short=$(git rev-parse --short $head3)
> >>> +	head3_short=$(git rev-parse --short $head3) &&
> >>> +	# unset commit encoding config
> >>> +	# otherwise %e does not print encoding value
> >>> +	# and following test fails
> >>
> >> I don't understand this comment. The test vector below already shows that
> >> an encoding is printed. Why would this suddenly be different with the
> >> updated tests?
> > I've changed tests. I've reverted back these ones, and added
> > new ones with no i18n.commitEncoding set
> >>
> >> Assuming that this change doesn't sweep a deeper problem under the rug,
> >> it's better to use test_config a few lines earlier.
> >>
> >>> +	git config --unset i18n.commitEncoding
> >>> +
> >>>  '
> >>>  
> >>>  test_format complex-encoding %e <<EOF
> >>>  commit $head3
> >>>  iso8859-1
> >>
> >> This is the encoding that I mean.
> > These encodings "have appeared" because we've changed 'setup':
> > we make commits with i18n.commitEncoding set
> 
> I understand why there are additional encoding entries in the expected
> output, but we see one encoding entry already listed without this patch.
> Why do you say "does not print encoding value" in the comment above?
I don't even remember today. I guess (that comment initially was written
loooooong time time ago), that was a "legacy" comment.
Nevermind,
nowadays it's removed ;)
> 
> >>
> >>>  commit $head2
> >>> +iso-8859-1
> >>>  commit $head1
> >>> +iso-8859-1
> >>>  EOF
> 
> -- Hannes
