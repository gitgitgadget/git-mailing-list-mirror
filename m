From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH 1/7] gitk: Enhance UI popup and accelerator handling.
Date: Thu, 9 Oct 2008 12:12:04 +0400
Message-ID: <bb6f213e0810090112l60d7b4c3v42e42d9d769c6057@mail.gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
	 <18669.20487.88439.584567@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 10:14:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knqe9-0003Cr-8R
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 10:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633AbYJIIMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 04:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755535AbYJIIMJ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 04:12:09 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:35734 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533AbYJIIMG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 04:12:06 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1394600eyi.37
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 01:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=M59WR2X2pg0N3zdduXubWLR4U3OaWvqK1q39Qo9KHJg=;
        b=weNgcKM2YQT8w1Z3taXUZv7qIKMq+idCWm8bSz/xyJb/XqOcKu36ZU+VPokl7XTjuE
         tYA2IgTAs+Fo0gW5fqk9J39cNZg1NY5xxm3L4aPI42R2H06fCPxZXg0b6dQkg8/AqvqU
         z5HK8ru+UgM8syDDNxacR/ZYZs6gf4VCSySPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VPLenDcL5Xr482RnHSGqVLUUF0wJwtPrc2BIAFEtwZVV9IbeyhnxGVPO8++SyJrOQd
         aNwelfE2OFhhJ0NJaXmTT9qgx5NSd9ZUzD5q0ZN4Gn2To66dZ4g/TxDfpHaSXbMqIoPj
         GtuKhL9q9luP1Fbf6OAwLT9rK1G1NbNl2b3ls=
Received: by 10.103.231.15 with SMTP id i15mr5107029mur.124.1223539924520;
        Thu, 09 Oct 2008 01:12:04 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Thu, 9 Oct 2008 01:12:04 -0700 (PDT)
In-Reply-To: <18669.20487.88439.584567@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97833>

On Thu, Oct 9, 2008 at 4:27 AM, Paul Mackerras <paulus@samba.org> wrote:
>> +    catch { bind . <Shift-Key-XF86_Switch_VT_4> {newview 0} }
>
> What is this key, or why is this line needed?

It is a workaround for an apparent bug in interaction between Tk and
XKB on some systems.
XKB configuration files bind those symbols to Ctrl-Alt-F*
combinations, but Tk's keyboard
handiling code sees them when Shift-F* is pressed. I'll be glad to
find a better fix, but that's
all I could do for now.

The catch wrapper is there to avoid erroring out if that keysym does not exist.

>> @@ -2484,10 +2501,10 @@ proc keys {} {
>>
>> -[mc "<%s-Q>          Quit" $M1T]
>>  [mc "<Home>          Move to first commit"]
>>  [mc "<End>           Move to last commit"]
>>  [mc "<Up>, p, i      Move up one commit"]
>> @@ -2521,11 +2538,11 @@ proc keys {} {
>>  [mc "<%s-plus>       Increase font size" $M1T]
>>  [mc "<%s-KP->        Decrease font size" $M1T]
>>  [mc "<%s-minus>      Decrease font size" $M1T]
>> -[mc "<F5>            Update"]
>
> I think it is useful to have the accelerator keys listed in the key
> binding help.

I don't insist on this part of the patch, it just seemed to be redundant now.

>> @@ -7501,6 +7534,7 @@ proc domktag {} {
>>      addedtag $id
>>      dispneartags 0
>>      run refill_reflist
>> +    return 1
>>  }
>>
>>  proc redrawtags {id} {
>> @@ -7539,7 +7573,7 @@ proc mktagcan {} {
>>  }
>>
>>  proc mktaggo {} {
>> -    domktag
>> +    if {![domktag]} return
>
> You need to change the error returns in domktag to say "return 0",
> otherwise this will give a "can't use empty string as operand of "!""
> Tcl error.

I did not know this. I'm not that familiar with Tcl...

Alexander
