From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 0/9] Narrow/Sparse checkout round 3: "easy mode"
Date: Sun, 17 Aug 2008 12:12:50 +0700
Message-ID: <fcaeb9bf0808162212y756465a5ib7ce3a8849765033@mail.gmail.com>
References: <20080815142439.GA10609@laptop>
	 <7v1w0pdze0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 07:13:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUaaT-0007hE-8G
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 07:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbYHQFMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 01:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbYHQFMx
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 01:12:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:1529 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbYHQFMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 01:12:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1345417fgg.17
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 22:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=V2JCzkU+UjOsCNix+A58tUBNR7XFmuhWCeP1bJAg/Hk=;
        b=EBjGZzQPS0MCYbE66eBBTXO51lQq+JpgggT7ik7pSigIpm7z4sQZoiB2o2/Tv1cQXE
         bO9doWSoeEKKOnakgEH6BqIfTDuCfTbtdljPZ1TOkZRavL4kkR0eNXm5Zz20DIoSscyy
         kF11YVEaMv6kw/XeskxoSlijvGdPVy/54YYT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Q/3ulSmyImgxSo0nOSqqX6MeIOnap3PkXRDu8hnbVECpTTv2ioHd4ohUxwsv9ygsqr
         T+WE881omxWJCC0i0GXbelDw9ihA8hNMwmKybLH7kVCfdGFGq/BQENtJwc6dLTbPIm2V
         j7xv/ShhD7ZlctqZqMXBSqevvDC50JhiuyNcU=
Received: by 10.86.98.10 with SMTP id v10mr3471470fgb.46.1218949970601;
        Sat, 16 Aug 2008 22:12:50 -0700 (PDT)
Received: by 10.86.93.13 with HTTP; Sat, 16 Aug 2008 22:12:50 -0700 (PDT)
In-Reply-To: <7v1w0pdze0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92575>

On 8/16/08, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>  > Another difference from the last round is "narrow rules" will not be preserved
>  > when switching branches. When you switch branch with no option, you will get
>  > full checkout. You may want to use --path|--add-path|--remove-path when
>  > switching branches to have narrow checkout again.
>
>
> You could save the "narrow rules" in the extension section of the index.
>  If the final form of this series needs to use a separate CE_NO_CHECKOUT
>  bit (which would make the resulting index incompatible with the current
>  git), the narrow rules section can be marked as "your git must understand
>  this" class of extension to make sure that people do not mistakenly access
>  an index written by this new version of git with the current or older git.

The problem is "narrow rules" may change over time in a way that git
may handle it wrong. Assume that you have a directory with two files:
a and b. You first narrow checkout a (which would save the rule
"checkout a"). Then you do "git checkout b". When you update HEAD,
what should happen?
 - consider only a and b in narrow area (new files not counted)
 - consider the whole directory in narrow area (new files counted)

This does not matter until we implement strict mode that only checkout
new files inside narrow area (the usage is similar to submodule).

>  > Now back to technical POV. I did not reuse CE_VALID (assume unchanged) bit
>  > because it has been used for core.ignorestat.
>
>
> I am not sure what's the relation between these two.

Because the usage is different? When you "git update-index foo" with
core.ignorestat=1, it will mark it CE_VALID. And if the same bit is
used for narrow checkout, the file is considered not existing in
workdir. I'd expect foo is still in my narrow area after "git
update-index foo".
-- 
Duy
