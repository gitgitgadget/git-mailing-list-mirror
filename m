From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified
 tracked files
Date: Thu, 12 Aug 2010 15:40:52 -0500
Message-ID: <20100812204051.GF2029@burratino>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
 <vpqsk2kjks7.fsf@bauges.imag.fr>
 <AANLkTimODL6j11D6QuUX4b47GwFOVOXdqkhqrRfRaxmq@mail.gmail.com>
 <7viq3fsirv.fsf@alter.siamese.dyndns.org>
 <AANLkTikDvcn4eFDdkv26ADzsipwD_ofkdYwu_0abeLA3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jens.Lehmann@web.de
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:42:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojebf-00024r-Re
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760594Ab0HLUmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 16:42:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38125 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760582Ab0HLUmY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 16:42:24 -0400
Received: by gyg10 with SMTP id 10so573260gyg.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 13:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AYB7DDFO1Tl+e6Y7toCMOwmGKWh/sOb+VtLg1HFHMq8=;
        b=uXP7vF/Mjg7IYIX1DqkOnRxL91pmVPrtajRr3ZyRCXw1I8WVTiraA0X/OAPq18Gx6O
         feJvlnt1H2TZVJaqiLUn1NSHXzsIk8u5Nv5ZFvjObU84tYWjEbMq0g0GQPJCdMCRmvR9
         En5uEPUMWwq3FyxurKFNXUcRGvjPzeDVGS/AM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=a+zBZyr50jiIV8hnQxs5a7muz0tkIk2TqNJXqtRXxydUr+SmTLqmZDT4xX/O4eyiz1
         jHY403VZWxdM0Ot1ksNN8d6wFiXK4Vlx5RNrzl6skEnQBKfx+SV75vXCN7K7UcLNstt8
         QjxmRkPLs9oDUfL45qf5lsMvYl4nzw4bnEm2U=
Received: by 10.231.34.70 with SMTP id k6mr684316ibd.25.1281645743747;
        Thu, 12 Aug 2010 13:42:23 -0700 (PDT)
Received: from burratino ([66.99.3.154])
        by mx.google.com with ESMTPS id n20sm260556ibe.17.2010.08.12.13.42.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Aug 2010 13:42:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikDvcn4eFDdkv26ADzsipwD_ofkdYwu_0abeLA3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153415>

Greg Brockman wrote:

> For example, in my personal usage, when I ignore a directory but trac=
k
> some files within it, this is because I don't want to specify an
> ignore for every single other file in that directory.  Also note that
> negated .gitignore entries don't seem to work in this case, i.e. a
> .gitignore with contents
> dir
> !dir/file
> won't actually let file be addable again.

Aside: yeah, this is something I have run into before.  The workaround
I used was to use a dir/.gitignore instead, like this:

 *
 !/file

which is ugly.

Maybe git should get internal support for something like

 dir/**

(meaning =E2=80=9Call files under dir=E2=80=9D) and =E2=80=9C!dir/file=E2=
=80=9D could be internally
munged to

 !/dir
 dir/**
 !dir/file

when it appears after =E2=80=9Cdir=E2=80=9D.
