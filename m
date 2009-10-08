From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] ls-files: make option parser keep argv[0]
Date: Thu, 08 Oct 2009 13:32:50 -0700
Message-ID: <4ACE4C72.4050400@gmail.com>
References: <1255011628-31841-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Thu Oct 08 22:44:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvzoJ-0007UM-Gh
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 22:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759660AbZJHUcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 16:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759649AbZJHUcc
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 16:32:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:23150 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759580AbZJHUc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 16:32:28 -0400
Received: by fg-out-1718.google.com with SMTP id 22so112658fge.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2009 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=fE8KAm7pe4l4cxOZGyVSIBtJsDM+9scklxOtLc5i1hM=;
        b=sr+UWsAIf9QBuZZgWelFyzmzYECae0E30/dQ0ErNiF6WuJAqRmL7gGwwd26M0bK51p
         Dtpo0Np40RiygEPq2l6jKO5HhZTkyss9v5g1EPdoTvhzXbcfpc16xx/2N/Ss43kLK3Tj
         poDaocu9sDPVw2yqOWtMLEk+BMq04/xmdS42E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=X5I4vdjdleodsHYVQ3VmjvmyPiAm4gjbw047DpqjJkL6NrTmxAVVuj87zyYmawKqX7
         if0NbRqdi8ezRpcPJQoNxcHIqhD3LFGkVliNGe89sc5rnwrYyb88V9axgF013sdevUD6
         IOpiStgHKQVCQ7oRIAxPSSbd3ahbBrzI1tGiM=
Received: by 10.86.158.29 with SMTP id g29mr1565498fge.4.1255033840905;
        Thu, 08 Oct 2009 13:30:40 -0700 (PDT)
Received: from ?192.168.1.2? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id l12sm531420fgb.26.2009.10.08.13.30.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 13:30:39 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <1255011628-31841-1-git-send-email-bwalton@artsci.utoronto.ca>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129716>

Ben Walton wrote:
> The ls-files built-in was not asking the option parser to maintain
> argv[0].  This led to the possibility of fprintf(stderr, "...", NULL).
> On Solaris, this was causing a segfault.  On glibc systems, printed
> error messages didn't contain proper strings, but rather, "(null)":...
>
> A trigger for this bug was: `git ls-files -i`
>
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
>

Patch looks good.

Just a thought, maybe we should change the fprintf(stderr,...) and
exit(1) call to a die() and replace the argv[0] with "ls-files" similar
to the die() on line 546. Then your diffstat becomes -1 instead of 0.
