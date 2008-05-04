From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 3/6] --color-words: Fix showing trailing deleted words at another line
Date: Mon, 5 May 2008 00:48:15 +0800
Message-ID: <46dff0320805040948g2956d724wb41f3eb8651443@mail.gmail.com>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
	 <1209874815-14411-4-git-send-email-pkufranky@gmail.com>
	 <alpine.DEB.1.00.0805041049150.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 04 18:49:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JshOb-0003Vq-I6
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 18:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbYEDQsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 12:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbYEDQsS
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 12:48:18 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:13570 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbYEDQsR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 12:48:17 -0400
Received: by an-out-0708.google.com with SMTP id d40so471749and.103
        for <git@vger.kernel.org>; Sun, 04 May 2008 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4KsrK4TptXwRIHrW6eT+bzcMyyYyT/6e7Qbe7btcHtw=;
        b=CjtKRdouVCARE+q5WiXP71TVK7Q4nFHR8rJ3T7cR/DEZIOTKRHibaaEr2nzP8yBaNT7N06GLvCrj9j+hRxZcTdUD8rok+Zo4/CG/DNc+1+axAc1KAtd07ui9YPRmzFWK0BqttBa5MlnYY1aCkZcDr+U5Q9jzgYRtmVGwzkD1z08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L3nbmAiMNickFL54hj2KaIH/4R2tEJBLSqE1ib3Avj7Gu2vV0nUM0HAVqBC61guWl7nh6otaMZZfb+4AtcVmxwzesM+DQZwCntOwqxbcl4cKAEKTvkjARivLSi1m3VfZcuDIbAMDuHSTocICrf2A+uYY2NusK3iq//eoRN37WfU=
Received: by 10.100.128.20 with SMTP id a20mr6724046and.121.1209919695246;
        Sun, 04 May 2008 09:48:15 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 4 May 2008 09:48:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805041049150.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81187>

On Sun, May 4, 2008 at 5:52 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Sun, 4 May 2008, Ping Yin wrote:
>
>  > With --color-words, following example will show deleted word "bar" at
>  > another line.
>
>  "will", or "used to"?

should be 'used to'

>  > This is caused by the unsymmetrical handling of LF in the plus and minus
>  > buffer in fn_out_diff_words_aux.
>
>  Is it not rather caused by the need to replace non-word-characters with
>  LF?

No, i think this has nothing to do with the replacing
non-word-characters with LF.

>
>  > Following is original unsymmetrical handling rules where LF represents
>  > a LF will be shown there.
>
>  I cannot parse this sentence.

Following is the original unsymmetrical handling rules

>
>  > The second rule causes any word following the trailing plus word will
>  > be shown in a different line.
>
>  I cannot parse this sentence.
>
>

The second rule causes any word following the trailing plus word to show
in a different line with the trailing plus word.

>
>  > @@ -417,10 +418,11 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
>  >       dwb_plus = &(diff_words->plus);
>  >       outfile = diff_words->file;
>  >
>  > -     if (dwp_minus->suppressed_newline) {
>  > -             if (line[0] != '+')
>  > -                     putc('\n', outfile);
>  > -             dwp_minus->suppressed_newline = 0;
>  > +     if ((dwb_minus->suppressed_newline && line[0] != '+') ||
>
>  If the previous version had dwp_minus, and the new version has dwb_minus,
>  I wonder if both compile and pass the test suite.
>

Oh, it's a typo in the former patch.


-- 
Ping Yin
