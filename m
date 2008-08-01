From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Fri, 1 Aug 2008 13:24:56 +0400
Message-ID: <37fcd2780808010224l68c2c717y5334a34d9de1de8d@mail.gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com>
	 <200807311257.49108.litvinov2004@gmail.com>
	 <20080731104529.GE7008@dpotapov.dyndns.org>
	 <200808011023.32139.litvinov2004@gmail.com>
	 <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com>
	 <7vbq0dtawp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 11:26:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOqtb-0008A7-Or
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 11:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbYHAJY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 05:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbYHAJY6
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 05:24:58 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:25344 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbYHAJY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 05:24:57 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1304470wfd.4
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rVJjxzECMjQ3Imc0Faahp9zJP4UfaQidxMBtPqA3NGI=;
        b=UZUejIAkkko9CfdwOlat6glrEkHpJr5wWBgzxNXRDX1vmYoEdC9hW61GBo4bKld/8c
         ZPpYZ+iEZZYlgGEjzjuRnPgiEomMUGFqWFDSDmBuepM4sTcWbpYU3ribiH2sw5/Mr3KV
         rcumddlc6YmGlG/poJcrhtxYDwCWhViwetiRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SfWoNwWw1wKtvsna32GpZ7tb8A/YIhwveI39Plc5t9mqbsMy3SBHL58zwTQMS0E7kd
         OvDHyvwj1f4bOCTWfd9rp2x8kxzBo3mORfKntJ5Z8Ai4MFHIKLltk8QqBXyMSo/q4aK3
         pH+nNfa/dIC4n1ik8QTxD29WwfLiCtOfdYVWE=
Received: by 10.142.162.9 with SMTP id k9mr3652959wfe.211.1217582697030;
        Fri, 01 Aug 2008 02:24:57 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Fri, 1 Aug 2008 02:24:56 -0700 (PDT)
In-Reply-To: <7vbq0dtawp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91045>

On Fri, Aug 1, 2008 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Dmitry Potapov" <dpotapov@gmail.com> writes:
>>
>> To being able to synchronize efficiently in both ways, you need to store
>> files exactly as they were received from SVN then there will be no
>> problem with applying binary delta patch. All CRLF conversion should be
>> done on checkout and checkin from/to Git repository.
>
> Ahh,... if that is the philosophy, perhaps we can teach --stdin-paths to
> optionally open the file itself and use index_pipe() like --stdin codepath
> does?

It is possible to do in this way, but it less efficient, because it uses
index_pipe, which does not know the actual size, so it reallocates the buffer
as it reads data from the descriptor, while index_fd uses xmap() instead.
So I sent another solution yesterday:
http://article.gmane.org/gmane.comp.version-control.git/90968

It is a bit hackish because I unset S_IFREG bit in st_mode to disable
conversion. In fact, my question what would be a better way to tell index_fd
to not do any conversion. If you think that it is better to use index_pipe,
which does not any conversion than I will redo my patch to use it instead.

Dmitry
