From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 1/5] mktag.c: adjust verify_tag parameters
Date: Mon, 12 May 2008 10:43:29 -0500
Message-ID: <482865A1.7040207@nrlssc.navy.mil>
References: <1210299589-10448-1-git-send-email-drafnel@example.com> <3712867.1210299524581.JavaMail.teamon@b301.teamon.com> <7vmymw3cst.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: drafnel@gmail.com, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 17:45:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvaD8-0005W0-B9
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 17:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbYELPoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 11:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbYELPoV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 11:44:21 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55557 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbYELPoU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 11:44:20 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m4CFhTNu014065;
	Mon, 12 May 2008 10:43:29 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 12 May 2008 10:43:29 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <7vmymw3cst.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 May 2008 15:43:29.0718 (UTC) FILETIME=[ED033560:01C8B446]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81876>

Junio C Hamano wrote:
> drafnel@gmail.com writes:
> 
>> From: Brandon Casey <casey@nrlssc.navy.mil>
>>
>> The size parameter should be a size_t since it is a string length.
> 
> Correct.
> 
>> There is no reason that the buffer argument should not be constant except
>> for the nul termination that is performed in the first few lines of this
>> function. This is not necessary, since a valid c string must always be
>> nul terminated and we can check whether we have exceeded the caller's
>> size parameter at the end of parsing the buffer.
> 
> Wait a minute.  The point of passing a stringlet as a tuple of <pointer to
> the beginning, length> is that you may not have a valid C string to begin
> with, isn't it?

I thought it was just to limit the scope of parsing.

Other functions that deal with non-nul-terminated memory segments (like memchr)
do not use char*, they instead use void*.

If we want to handle non-nul-terminated memory segments here, we should
probably allocate a new string to copy the memory segment into so we can
ensure it is nul-terminated. Otherwise we can't use any of the str*()
functions safely.

-brandon
