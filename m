From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: [PATCH 1/2] Add strbuf_initf()
Date: Thu, 6 Mar 2008 11:53:50 +0000
Message-ID: <3f4fd2640803060353w70651522w4b3896b8106b01c0@mail.gmail.com>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
	 <alpine.LSU.1.00.0802281159550.22527@racer.site>
	 <200803052221.12495.johannes.sixt@telecom.at>
	 <alpine.LSU.1.00.0803052317350.15786@racer.site>
	 <7vir00lski.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0803052327570.15786@racer.site>
	 <alpine.LSU.1.00.0803060212170.15786@racer.site>
	 <20080306063331.GA7325@glandium.org>
	 <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com>
	 <alpine.LSU.1.00.0803061153400.15786@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mike Hommey" <mh@glandium.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 12:54:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXEg9-0006mr-Tc
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 12:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758858AbYCFLxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 06:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758446AbYCFLxw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 06:53:52 -0500
Received: from el-out-1112.google.com ([209.85.162.180]:28512 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbYCFLxv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 06:53:51 -0500
Received: by el-out-1112.google.com with SMTP id v27so2797757ele.17
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 03:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lhzfhx35ijNyRzc5t1Vykn0j8gcmzvbXe6iApDw9Yao=;
        b=XVOpQHMczpHqD5ie8mhTphRU35FQ+46IwCXjIghSeKnQD+FRu+p3aoy5nsT0ht86pWrU40hwewgbq6BreqZjF0IMNuQkYAuwG2qTw4RRryTatLHZWcwKFYfWHKTU1n6JLeR1N47mhAem9Sa8ZDCBBG2T+zNI4W3jNblkv4X93IE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IHZ9UMRPm3nLJhQWux0jzua1Pou1Bs7hjp8DMSVEkHukPtl2FDMPJn7SNzdwuy++aTAVDUhzMWVSHHA3KEcvpLGRZVzqepbnbTM8NGva3+sxvw4e3sIRnHNbFJL9QNqeHJXzXHndiqFOxGPqBTfSzyDtuhrzqOM6u3XXP6AC3rs=
Received: by 10.141.163.12 with SMTP id q12mr1883904rvo.190.1204804430080;
        Thu, 06 Mar 2008 03:53:50 -0800 (PST)
Received: by 10.141.23.10 with HTTP; Thu, 6 Mar 2008 03:53:50 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0803061153400.15786@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76382>

On 06/03/2008, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  On Thu, 6 Mar 2008, Reece Dunn wrote:
>
>  > On 06/03/2008, Mike Hommey <mh@glandium.org> wrote:
>  > > On Thu, Mar 06, 2008 at 02:14:43AM +0100, Johannes Schindelin wrote:
>  > >  >
>  > >  > The most common use of addf() was to init a strbuf and addf() right
>  > >  > away. Since it is so common, it makes sense to have a function
>  > >  > strbuf_initf() to wrap both calls into one.
>  > >  >
>  > >  > Unfortunately, C (and cpp) has no way to make this easy without
>  > >  > code duplication, as we need to va_init() in strbuf_addf() possibly
>  > >  > a few times.  So the code for addf() is copied.  Fortunately, the
>  > >  > code is pretty short, so not too much had to be copied as-is.
>  > >
>  > >
>  > > The problem with code duplication is not about code size, but more
>  > > about not forgetting to fix bugs in all incarnations of the duplicated
>  > > code.
>  > >
>  > > Is it so ugly to use a macro ?
>  >
>  > Why not have a strbuf_vaddf and strbuf_vinitf that take a va_arg as a
>  > parameter. This would mean that you don't have code duplication, and it
>  > is flexible enough if you want to add more customisations in the future.
>  > No macro needed. This is what the printf/scanf family of functions do.
>
>
> The problem is that we have to restart va_list() if the buffer was too
>  small.

Ok.

>  So your suggestion is out, unless you suggest to implement the whole
>  printf mechanism... which I hope you're not.

No, that was not my intention. My intention was that they were simple
forwarding functions that handled the va_start and va_end calls.

Is it possible to pass a void * to a strbuf_vaddf function that you
can pass to va_start, so you can then restart the va_list?

- Reece
