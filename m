From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] lookup_commit_reference_gently: do not read non-{tag,commit}
Date: Fri, 31 May 2013 07:52:09 +0700
Message-ID: <CACsJy8BDM=1xfZLvLs-G-0xnneaOAvzZOOXjdTZEtsT9PEvHeg@mail.gmail.com>
References: <2d926e4dbd218b2305f50652c00a5c1d87e81208.1369943791.git.trast@inf.ethz.ch>
 <5cc40825d5b4fb3382e4c054c49adf5e6b6fe110.1369943791.git.trast@inf.ethz.ch> <20130530212223.GA2135@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 31 02:52:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiDaM-00021W-KY
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 02:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab3EaAwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 20:52:47 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:64760 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3EaAwq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 20:52:46 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so1181729lbf.28
        for <git@vger.kernel.org>; Thu, 30 May 2013 17:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VDJcWmn6lXhmkAS1sjtlpMSHR7TiMhFFo54b9MC3K1g=;
        b=Z4zdiSTm/oYOJq9hh8iSn3BQbsmAQ37yylEQAifxyJ3yFlXxx/ugU3i3s3BCKPYbx4
         Ex5gzIZB2hFKqU+CwwdTtA/szHVbxpmSKZb1xCfclbYZGrsv5w1oFIcvpqb29Buwmzut
         kvc3SSYUR8pRpbO25rZU1eYccbXOKEgVi33ZgIztKs6MfL19pwwWxD3PLkmvoXkX7BNe
         OVWj72TE3bxffPy+dKOE79U/9YgOlPWHCE3h24i3akKqFP7PdYwgQUb5vo6jjyKfno6L
         2ZYlvc9nLfufPkgVl9KdiwhZjyBVSl3mWg4cCDSpolFX106PMwOX8uvsj3cDxnD/F3/u
         PHDQ==
X-Received: by 10.112.182.10 with SMTP id ea10mr4821878lbc.36.1369961564444;
 Thu, 30 May 2013 17:52:44 -0700 (PDT)
Received: by 10.114.24.234 with HTTP; Thu, 30 May 2013 17:52:09 -0700 (PDT)
In-Reply-To: <20130530212223.GA2135@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226041>

On Fri, May 31, 2013 at 4:22 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 30, 2013 at 10:00:23PM +0200, Thomas Rast wrote:
>
>> lookup_commit_reference_gently unconditionally parses the object given
>> to it.  This slows down git-describe a lot if you have a repository
>> with large tagged blobs in it: parse_object() will read the entire
>> blob and verify that its sha1 matches, only to then throw it away.
>>
>> Speed it up by checking the type with sha1_object_info() prior to
>> unpacking.
>
> This would speed up the case where we do not end up looking at the
> object at all, but it will slow down the (presumably common) case where
> we will in fact find a commit and end up parsing the object anyway.

Perhaps turn "quiet" into a bitmap and only let git-describe do this?
--
Duy
