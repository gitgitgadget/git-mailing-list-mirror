From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git 1.6.6.1 on glibc 2.2
Date: Sun, 24 Jan 2010 06:27:51 -0600
Message-ID: <20100124122751.GA3265@progeny.tock>
References: <x6y6jn4txy@gzp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gabor Z. Papp" <gzp@papp.hu>
X-From: git-owner@vger.kernel.org Sun Jan 24 13:28:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ1ZS-000706-PR
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 13:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab0AXM16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 07:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753717Ab0AXM16
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 07:27:58 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:58805 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab0AXM15 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 07:27:57 -0500
Received: by iwn10 with SMTP id 10so2145291iwn.22
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 04:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KF9pANBegCBJLAxucR2hwTOnnIIJoIeUG9NJdeUyOBE=;
        b=AQ4Lk7uQRucUyptxJy9IMW06C8zNu2TyDeEJC1P1mMlZcDJwm6lEZcsUM6e3eo2Hwg
         i9d8qQKQmUrgaYZ8XtfZVigZZ2p9ELaPJ/YMPuUmdpSpzwwX2x/wIbTYSt92nReyoJmw
         ygT40Xffx5dcQuHH9aEBkxXJ3r8YePZoEalig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gfqrzXrCsvfY+AmQsW6JqXX91riFODIBH11t6mUuQtkbWylS4ZAolBUpig7ELvit3q
         uTgGf3q6p0oinOqEyGIHZN7qwX/qneu2iTiKAB4Qm9YVz5l2KuM+8uj3ZNBO4ycoF67g
         k1rBFWhr6DJDSl6ug7p6Xez5fhbe7CfxOEjVg=
Received: by 10.231.122.36 with SMTP id j36mr2146341ibr.21.1264336076792;
        Sun, 24 Jan 2010 04:27:56 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3908234iwn.8.2010.01.24.04.27.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 04:27:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <x6y6jn4txy@gzp>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137893>

Hi!

Gabor Z. Papp wrote:
> Hello all,
> 
> trying to compile git 1.6.6.1 on Linux 2.4.37.7, glibc 2.2.5:
> 
> read-cache.c: In function 'fill_stat_cache_info':
> read-cache.c:72: error: 'struct stat' has no member named 'st_ctim'

Thanks for the report.  Perhaps:

$ grep -C3 st_ctim Makefile
# randomly break unless your underlying filesystem supports those sub-second
# times (my ext3 doesn't).
#
# Define USE_ST_TIMESPEC if your "struct stat" uses "st_ctimespec" instead of
# "st_ctim"
#
# Define NO_NSEC if your "struct stat" does not have "st_ctim.tv_nsec"
# available.  This automatically turns USE_NSEC off.
#
# Define USE_STDEV below if you want git to care about the underlying device

Hope that helps,
Jonathan
