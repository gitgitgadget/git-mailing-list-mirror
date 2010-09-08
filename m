From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/5] en/object-list-with-pathspec (v3?)
Date: Wed, 8 Sep 2010 01:47:21 -0600
Message-ID: <AANLkTimFRUfK2+yNGkgJX8K-0N5QYOp4ud2O7afH_iNz@mail.gmail.com>
References: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 09:47:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtFNP-0006WL-Sa
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 09:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169Ab0IHHrX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 03:47:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43177 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349Ab0IHHrW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 03:47:22 -0400
Received: by fxm16 with SMTP id 16so546789fxm.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4YyA9Bh0LtE+kKqhIMI/reR5rqjwc9VAnuINsEVHHzo=;
        b=sF8tKh82A/04/ArKvBL/cT//e/ye1/m1o6rN2slJdeIbncHqjGi/1qEY0dY0rvZtrN
         ltkAaEkA38MDBEIECy5TNDqmxYBjVPCc+PDdJklvVSZZtcvesJ/kBF/PMS4OYLB/o35l
         jSMZ29lhxGyW69B868cc0hEmXHHmPLmxsyxI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DPNCt+wkBbU2Sgy8QUx0U4G8Xca/5m2S9MpLc8/6IrPAHsFp8JXK4xfzlPOFlrmZ7f
         HaGjrdYeqA+YKCSXFLxzrb+QT9AP/zmtOH7WI+RFVGogmChYuoWTV6UywT8gBiJpa1On
         ty4AsXiLEq+wqCMTXFGXl6FyeP2h102iA8sX8=
Received: by 10.223.114.74 with SMTP id d10mr395911faq.1.1283932041182; Wed,
 08 Sep 2010 00:47:21 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Wed, 8 Sep 2010 00:47:21 -0700 (PDT)
In-Reply-To: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155774>

2010/9/7 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> Changes from last time is tree_entry_interesting() now takes
> struct exclude * as the pathspecs.
>
> I think there'll be a bit of performance loss because diff_options.el
> is not initialized from the beginning. But that requires more changes
> outside tree-diff.c (makes sure that diff_options.el is copied proper=
ly,
> makes sure that diff_tree_setup_* is called ...) So one step at a tim=
e.
> I'm working on it.

Looks reasonable to me so far.  I believe your series already makes
nr_paths, paths, and pathlens fields from diff_options unused (other
than via exclude_list) -- yes?  If so, that suggests that we could
just modify diff_tree_setup_paths() to do the work that your new
diff_tree_setup_exclude_lists() is doing (and to take an exclude_list*
instead of a diff_options*).  Then you wouldn't need to worry about
doing the setup "on-the-fly" and the performance differences should go
away.

Am I understanding correctly, and is that the route you're going?
