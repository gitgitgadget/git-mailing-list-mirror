From: Andreas Ericsson <ae@op5.se>
Subject: Re: found a resource leak in file builtin-fast-export.c
Date: Thu, 09 Jul 2009 13:30:56 +0200
Message-ID: <4A55D4F0.5020002@op5.se>
References: <20090709075728.137880@gmx.net> <200907091031.43494.trast@student.ethz.ch> <alpine.DEB.1.00.0907091302520.4339@intel-tinevez-2-302> <200907091324.17643.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Ettl <ettl.martin@gmx.de>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 09 13:31:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOrqL-0003L3-MC
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 13:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbZGILbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 07:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756647AbZGILbE
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 07:31:04 -0400
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:42651 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755640AbZGILbD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 07:31:03 -0400
Received: from source ([74.125.78.145]) by na3sys009aob101.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSlXU9Hc6I31rVW4e2z7Q+QsgxxWr+/4N@postini.com; Thu, 09 Jul 2009 04:31:03 PDT
Received: by ey-out-1920.google.com with SMTP id 5so30143eyb.26
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 04:30:59 -0700 (PDT)
Received: by 10.210.60.8 with SMTP id i8mr380995eba.4.1247139059392;
        Thu, 09 Jul 2009 04:30:59 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 10sm5167163eyd.18.2009.07.09.04.30.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 04:30:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200907091324.17643.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122968>

Thomas Rast wrote:
> Johannes Schindelin wrote:
>> On Thu, 9 Jul 2009, Thomas Rast wrote:
>>
>>> Martin Ettl wrote:
>>>> -	if (ferror(f) || fclose(f))
>>>> +	if (ferror(f))
>>>>  		error("Unable to write marks file %s.", file);
>>>> +  	fclose(f);
>>> You no longer check the error returned by fclose().  This is
>>> important, because the FILE* API may buffer writes, and a write error
>>> may only become apparent when fclose() flushes the file.
>> Indeed.  A better fix would be to replace the || by a |, but this must be 
>> accompanied by a comment so it does not get removed due to overzealous 
>> compiler warnings.
> 
> Are you allowed to do that?  IIRC using | no longer guarantees that
> ferror() is called before fclose(), and my local 'man 3p fclose' says
> that
> 
>        After the call to fclose(), any use of stream results in
>        undefined behavior.
> 

A more important question; Do we really care? I haven't looked closely
at the code, but afair the marks file is written once per invocation,
so leaking its file descriptor sounds like something we won't really
bother about.


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
