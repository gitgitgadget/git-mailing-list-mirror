From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [RFC] struct *_struct
Date: Thu, 5 Aug 2010 18:43:21 -0400
Message-ID: <20100805224321.GA22430@localhost.localdomain>
References: <20100804150843.GA2762@localhost.localdomain>
 <7vaap2fafm.fsf@alter.siamese.dyndns.org>
 <AANLkTin_6gaYF++N2GBgDsedfo7mY7yG5H99=-DxCa5E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 00:43:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh99y-0007cs-Uy
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 00:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934723Ab0HEWnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 18:43:32 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38618 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934675Ab0HEWn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 18:43:26 -0400
Received: by vws3 with SMTP id 3so5582520vws.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 15:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gQ7NzWKaqMqXqEtxgo5ujJ/Q3Qjz1lH1FL/jbYSUaos=;
        b=lDDUY2HETyc9PCT3OxFN0ksR/GDqokVt5MSQG6r0nKFRq9fjQphCnChf50jwuFeAhx
         6tKiyydztyUpmSRdnAqsEsQXlRn9NhmtX5dQksygDND+GUffnQJHdxS7dR61OKrKmNm6
         ZGRg/lv8F02gzAVoplbqWu9myV6V99O9Oj8yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EgeVQfOsPapAZRh3XIfKWZucZWvKVcFRv8mGAJ+8MOlWLOO5/xPtsIhcVGlApYrQ0m
         r3DhCVZX8ejgwPY9cHq/3L9UJfWP1sWzNLUZR1WmYYo5Ci1w3lWL6Qpyi70Gu5NVskdc
         AXnIrhiM/F4MrJVSyo2/1jVaMtyL7mbWhkiQg=
Received: by 10.220.88.152 with SMTP id a24mr7656041vcm.269.1281048205285;
        Thu, 05 Aug 2010 15:43:25 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id v11sm433431vbb.13.2010.08.05.15.43.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 15:43:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin_6gaYF++N2GBgDsedfo7mY7yG5H99=-DxCa5E@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152734>

On Thu, Aug 05, 2010 at 11:20:14AM -0500, Michael Witten wrote:
> On Wed, Aug 4, 2010 at 14:24, Junio C Hamano <gitster@pobox.com> wrote:
> > I hate... "typedef foo struct foo"
> 
> How come?

In my opinion, it creates ambiguity. If I have
    
    typedef struct foo foo;

And I have "foo" used in a code snippet, it is much less easier to see
if foo is being used in the type context or if its an instance, since
I like to do

    struct foo foo;

which reads much less well as:

    foo foo;


Its also much less easier to grep though to find all the places the
type is used. If I do

    $ git grep "foo"

I will end up with the instances and the struct type. whereas I can do

    $ git grep "struct foo"

to find (most|all) of the types, depending on whether the code uses
decent practices (there shouldn't be a second space between struct and
foo, or a newline between them).

I could also use a similar regular expression to find all the
instances (ie, all the instances of foo that aren't prefixed with
struct).
