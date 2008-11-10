From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GITK)] gitk: Fix commit encoding support.
Date: Mon, 10 Nov 2008 15:06:39 +0300
Message-ID: <bb6f213e0811100406l2fcde5b8k8772360947b948fd@mail.gmail.com>
References: <200811091806.07550.angavrilov@gmail.com>
	 <18712.7942.767651.569321@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 13:07:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzVYi-0008Eb-Jd
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 13:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbYKJMGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 07:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbYKJMGl
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 07:06:41 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:3092 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbYKJMGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 07:06:40 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2563227wfd.4
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 04:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=omh6V2qj2tyiVj5yHP2rbSevhZKcUXTy5uDJx8PXaDI=;
        b=bLUEkv7tGrG41BN0e6XfoOzrD1DY04i02DTUjVa46W+Nf09xM//IWE6YCauyVRu9re
         JJD04PLjeRCbIGcR5QlbKtTk7iNAHOq1lZo0Nk41jo1iPHXaSwxV9wZs7LxEWXfJtB4v
         85730Syymra4gRbJd8dvDafuuqfYEtq977PIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AxdDtEDLvt65ufusIfSQbgnR9GCWeEEa9TClscny8KOOto3dnmUR+dHLx5RRARdoVr
         DMU3yOF7RowAdcKuMMU+lburpaxsZwWaZjJCUUJIKz2dTRX1zmHbcXnsIzaYUSkZ/RsZ
         J14KgQ+Aml4C0JjuGxVoFCyp7R1Y7bLxpZ3IY=
Received: by 10.142.207.8 with SMTP id e8mr2358849wfg.198.1226318799634;
        Mon, 10 Nov 2008 04:06:39 -0800 (PST)
Received: by 10.142.216.21 with HTTP; Mon, 10 Nov 2008 04:06:39 -0800 (PST)
In-Reply-To: <18712.7942.767651.569321@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100520>

On Mon, Nov 10, 2008 at 2:46 PM, Paul Mackerras <paulus@samba.org> wrote:
> Alexander Gavrilov writes:
>
>> +proc do_readcommit {id} {
>> +    global tclencoding
>> +
>> +    # Invoke git-log to handle automatic encoding conversion
>> +    set fd [open [concat | git log --no-color --pretty=raw -1 $id] r]
>> +    # Read the results using i18n.logoutputencoding
>> +    fconfigure $fd -translation lf -eofchar {}
>> +    if {$tclencoding != {}} {
>> +     fconfigure $fd -encoding $tclencoding
>
> Does this mean there are two conversions going on, one inside git log
> and another inside Tcl?  Is there a reason why it's better to do two
> conversions than one, or is it just more convenient that way?

That makes the processing flow uniform with the usual code path.

> Would an alternative approach have been to read the output of git
> cat-file with -translation binary, look for an encoding header, and do
> an encoding convertfrom based on the encoding header?  What would be
> the disadvantage of such an approach?

If all commits were loaded through cat-file, that would be the way to
go. Otherwise, when one code path uses one method of conversion, and
another one, which is used rarely and semi-randomly, a different
method, it may lead to confusing results if something goes slightly
wrong.

Alexander
