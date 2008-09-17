From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH/RFC 2/2] git-gui: Do not automatically stage file after merge tool finishes
Date: Wed, 17 Sep 2008 16:25:47 +0400
Message-ID: <bb6f213e0809170525q286f5d42xfd734660dc935cbf@mail.gmail.com>
References: <200808310052.21595.angavrilov@gmail.com>
	 <1221651652-3712-1-git-send-email-johannes.sixt@telecom.at>
	 <1221651652-3712-2-git-send-email-johannes.sixt@telecom.at>
	 <1221651652-3712-3-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Johannes Sixt" <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Sep 17 14:27:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfw7y-0008SZ-8g
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 14:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbYIQMZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 08:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbYIQMZu
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 08:25:50 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:63256 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbYIQMZt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 08:25:49 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1566187gvc.37
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yTDN5Qh58C+BazG25FB3C24VlKRANRxsP781Th0yxxQ=;
        b=C0fbk6WT1SHEONPaRBc3s8YLkSr43qBj1ptOXZyRNRsmylj0JcJtR28z9Twh3sSyn8
         /DNBY+1waYLcB80han2GeynWYgIRlhnc1A19pLoEKegaBmKmEwhtkt8rQ/+U2yU2yRdA
         R5wrs76zEru1klNzTC2j03Fszdu67+1rnK6+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Teg8aQxCTfX/WPrk0avWlz18ZI3FBPYzVXwnVZ5NkkdlzUqyXanbuWB1dUcVD9gC4f
         nMHO7yNKLg2NzFip2+8DkndvWnaTBO28v+AI8K8hLT6wcCpdw+cQnZpQYs7LBFp1N2J6
         ojFrOV0+jSa5O47RARiIbsr+H1WAuM1DHVq60=
Received: by 10.103.223.20 with SMTP id a20mr1732941mur.86.1221654347391;
        Wed, 17 Sep 2008 05:25:47 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Wed, 17 Sep 2008 05:25:47 -0700 (PDT)
In-Reply-To: <1221651652-3712-3-git-send-email-johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96099>

On Wed, Sep 17, 2008 at 3:40 PM, Johannes Sixt <johannes.sixt@telecom.at> wrote:
> If a merge tool was invoked on a conflicted file and the tool completed,
> then the conflicted file was staged automatically. However, the fact that
> the user closed the merge tool cannot be understood as the unequivocal
> sign that the conflict was completely resolved. For example, the user
> could have decided to postpone the resolution of the conflict, or could
> have accidentally closed the tool. We better leave the file unstaged and
> let the user stage it explicitly.

It completely reproduces the logic that git-mergetool uses. Namely, if
the file is unchanged, it asks explicitly, and if the tool returns a
non-zero exit code, it does not stage at all.

You also cannot simply remove merge_add_resolution, because then it
would leave the diff view stale.
