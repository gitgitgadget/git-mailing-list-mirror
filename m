From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: Bug: UTF-16, UCS-4 and non-existing encodings for git log result in incorrect behavior
Date: Wed, 12 Nov 2008 19:17:53 +0300
Message-ID: <bb6f213e0811120817i20d5c0ajf0c9e289c11387a6@mail.gmail.com>
References: <85647ef50811120532h778769ddx69f0b111dbad359a@mail.gmail.com>
	 <alpine.DEB.1.00.0811121521390.30769@pacific.mpi-cbg.de>
	 <85647ef50811120727j730cb6e3lf4103c200d042fb9@mail.gmail.com>
	 <alpine.DEB.1.00.0811121714280.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 12 17:19:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0IR5-0007XT-Hu
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 17:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbYKLQR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 11:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbYKLQR4
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 11:17:56 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:5567 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbYKLQRz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 11:17:55 -0500
Received: by yw-out-2324.google.com with SMTP id 9so215904ywe.1
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 08:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ycSXlfiFZZC0KsbDfr0YtmYEIJIbxOcP5Mr76NHtiDs=;
        b=dWabeEfDRzz+4RisIV93YFW8O/SHh1961GaeRq4ionq1E1JnMIiSUUibeFtRMKbbnA
         cwl/XkdkSCMuTG59OB7Or+D3uW3IgMpjE1LajTBXnFRn/jJKSBARYKM0eqpAwjivGgEt
         DauXRAK+Oj6kY/zynoetY50nndfkmuDEKRghM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ad1sgnFWTMGeaAatT2qyUBmGxjDKzl9m86S65yPedtvalsPtTDTKHtaDtZug4j/mvo
         SBULdGa3fOrxpfBmFEmbp5JZg7UNz/2g3DUM2QWurqQ9ATwRx34ugPEg98/+SYQWKFOf
         rH2QUAng1VB1KtoBeUUR0q4NJUEYjSXswNrJc=
Received: by 10.142.177.5 with SMTP id z5mr3569470wfe.240.1226506673560;
        Wed, 12 Nov 2008 08:17:53 -0800 (PST)
Received: by 10.142.216.21 with HTTP; Wed, 12 Nov 2008 08:17:53 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811121714280.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100762>

On Wed, Nov 12, 2008 at 7:15 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> [re Cc:ing the list]
>
> On Wed, 12 Nov 2008, Constantine Plotnikov wrote:
>
>> On Wed, Nov 12, 2008 at 5:22 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Wed, 12 Nov 2008, Constantine Plotnikov wrote:
>> >
>> >> If UTF-16[BE|LE] or UCS-4[BE|LE] encodings are used with git log, the
>> >> git completes successfully but commit messages and author information
>> >> are not shown. I suggest that git should fail with fatal error if such
>> >> zero producing encoding is used.
>> >>
>> >> If the incorrect encoding name is used, the git log does not perform any
>> >> re-encoding, but just display commits in their native encoding. I
>> >> suggest that git should fail with fatal error in this case as well.
>> >
>> > Have you set the correct encoding with i18n.commitEncoding?  If not, you
>> > should not be surprised: Git's default encoding is UTF-8, and that fact is
>> > well documented, AFAICT.
>> >
>> Commit encoding is set correctly. The problem is that git log and git
>> show do not support the *output* encodings UTF-16 and UCS-4 and
>> silently fail in that case instead of reporting the error.
>
> That looks more like an iconv bug to me.  I assume you are using Windows?
>

Iconv has no way to know that git cannot work with ASCII-incompatible
encodings, and UTF-16 is incompatible, because it fills the output
with loads of zero bytes. Git both truncates messages on these bytes,
and forgets inserting them in strings that it produces itself.

A separate problem is that it allows creating commits with invalid
encoding names, which may be unnoticed for a long time in an
environment with uniform commitencoding settings.

Alexander
