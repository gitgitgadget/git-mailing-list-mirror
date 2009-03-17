From: Carlos Rica <jasampler@gmail.com>
Subject: Re: [PATCH] builtin-tag.c: remove global variable to use the callback 
	data of git-config.
Date: Tue, 17 Mar 2009 18:57:28 +0100
Message-ID: <1b46aba20903171057r4fb4697eo3b8abc62a45fe858@mail.gmail.com>
References: <1237301031.10001.13.camel@equipo-loli>
	 <alpine.DEB.1.00.0903171646140.6393@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 17 18:59:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjdZF-0004JN-5e
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 18:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbZCQR5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 13:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754966AbZCQR5c
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 13:57:32 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:60044 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbZCQR5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 13:57:31 -0400
Received: by bwz17 with SMTP id 17so185476bwz.37
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 10:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4X98WBMhXr3dZq8rnE4N5cGU2QKK8uHqa0pRlwjaoTs=;
        b=XGCiYUH/irkc7tH5hzXqlUqr8ErLLONaAA2aYqmvL6dCmfIFUzRC39fqdAPyectKO9
         gOmJZqXg+Kc4W7WgkUEV3i3JDcKkTUWlHLbcd8UU4jVfOamts5fV9kiKhYEraXl0ByLt
         tj0rCFAQyz5bb/HowalzmR5sHW7EjmG8fxY5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HXFGnITIzOGdboIicco413j6mUDqqhsBXIwPy33Re664pYYTsHvBo4SIhiknVSFrkt
         kApLa7HKVFzXuygU01EHsTSfwJDQMQtHSY/8v2B+j/CIVnr2CEA4mu5amkH+S59+HDnd
         Cr/nv3nhDIVGp6iUP3g9rv3wnDQk1lwnEBVnY=
Received: by 10.223.113.68 with SMTP id z4mr252980fap.72.1237312648467; Tue, 
	17 Mar 2009 10:57:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903171646140.6393@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113512>

On Tue, Mar 17, 2009 at 4:47 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
> On Tue, 17 Mar 2009, Carlos Rica wrote:
>> @@ -164,11 +162,10 @@ static int do_sign(struct strbuf *buffer)
>>       int len;
>>       int i, j;
>>
>> -     if (!*signingkey) {
>> -             if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
>> -                             sizeof(signingkey)) > sizeof(signingkey) - 1)
>> -                     return error("committer info too long.");
>> -             bracket = strchr(signingkey, '>');
>> +     if (!signingkey->buf[0]) {
>
> It is probably better to ask for !signingkey->len (think of trying to
> understand the code in 6 months from now).

I was in doubt here. By avoiding the use of signingkey->len  I was
trying to say that you cannot rely in such field if we touch the
buffer directly, as it happens below:

   bracket = strchr(signingkey->buf, '>');
   if (bracket)
      bracket[1] = '\0';
