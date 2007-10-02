From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: what's a useful definition of full text index on a repository?
Date: Tue, 2 Oct 2007 11:48:53 -0400
Message-ID: <9e4733910710020848l496ee49ej4c243b5f62bca6c0@mail.gmail.com>
References: <e1dab3980710010933u6a7324f0wa8230d67ee0846e2@mail.gmail.com>
	 <9e4733910710011025y790800b5s4e8cf65409bc2cce@mail.gmail.com>
	 <e1dab3980710020234l1951349r38657c68aa7ef5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "David Tweed" <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 17:49:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icjzb-00016h-AH
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 17:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbXJBPs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 11:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbXJBPs4
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 11:48:56 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:61970 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbXJBPsz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 11:48:55 -0400
Received: by nz-out-0506.google.com with SMTP id s18so2959372nze
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NLrV97kIjB1hmFVybueQdXeFv+pb3Wn0RAL2gulqQqM=;
        b=cdpXuSEmSZi3NHskycXJcfDK0225hArFSSaxwDCpRToO+k8lAnuS5B78zW4hdRFSYWyJ3tTizb3coG1SQKIf9tt1riw0T0WaXuvJ/5aQ2wjMwa51rrEjUJqGjhFDj22MQHasbi3A/ILhtGvbUr6HJb7DKR+uhZZ31ft5pPVKDco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JM99XdWJuv7jJnDFl04oTrQij7yI7DFnpZgSdcXXhf5c5B75un7K4XKAqcVuO4V05KBb5+AjLGL+nKvqSPpJiOZGu+53LUhVy8+C3bNRxrEf55E9AOqTWS3jEytBqNU8UJAckK8GFDZ6lYB66oBKFvxHlNpmhRZdx+WXPbM5GhU=
Received: by 10.114.174.2 with SMTP id w2mr5828057wae.1191340133701;
        Tue, 02 Oct 2007 08:48:53 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Tue, 2 Oct 2007 08:48:53 -0700 (PDT)
In-Reply-To: <e1dab3980710020234l1951349r38657c68aa7ef5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59695>

On 10/2/07, David Tweed <david.tweed@gmail.com> wrote:
> > Full text indexing can also achieve high levels of compression as
> > stated in the earlier threads. It is full scale dictionary
> > compression. When it is being used for compression you want to apply
> > it to all revisions.
>
> Well, as I say I'm not convinced it makes sense to integrate this with
> existing pack stuff precisely because I don't think it's universally
> useful. So you seem to end up with all the usual tricks, eg, Golomb
> coding inverted indexes, etc, _if_ you treat each blob as completely
> independent. I was wondering if there was anything else you can do
> given the special structure that might be both more useful and more
> compact?

Dictionary compression can be used without full-text indexes. It is
just really easy to build the full-text index if the data is already
dictionary compressed. Dictionary compression works for everything
except binary or random data.

Git is already using a small scale dictionary compressor via zip. I
suspect doing a full scale dictionary for a pack file and then using
arithmetic encoding of the tokens would provide substantially more
compression. The big win is having a single dictionary instead of a
new dictionary each time zip is used.

When we were working on Mozilla, Mozilla changed licenses three times.
The license text ended up taking about 30MB in the current scheme.
With full dictionary compression this would reduce down to a few kb.

More compression is good for git. It means we can keep more data in
RAM and reduce download times. With current hardware it is almost
always better to trade off CPU to reduce IO.

-- 
Jon Smirl
jonsmirl@gmail.com
