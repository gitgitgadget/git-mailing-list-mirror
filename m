From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v3 0/6] git_config callers rewritten with the new config
 cache API
Date: Mon, 21 Jul 2014 19:30:47 +0530
Message-ID: <53CD1D0F.5000605@gmail.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>	<vpqegxeeuyb.fsf@anie.imag.fr> <53CD1280.1080107@gmail.com> <vpqy4vmakq3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 21 16:01:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9E9F-0007l6-Uj
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 16:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbaGUOA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 10:00:58 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:61625 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230AbaGUOA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 10:00:57 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so9735492pad.36
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 07:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=utmzPHSkLyQg/UIdWX9wZnw1rmthaOLflrEQ2ZW+Hp0=;
        b=rJ4OK8O6f/8NVEIt+szruRIREC7wzuhUrrjDF3i2KfSkmlnQquRkZhBx6jfIzqGLwg
         VFVlOa0X8YUPJlumAxmE5/yVR5FyKJkObKgLivp0OsInQ+jOCPaUcUcqiOfJxvVSOr4+
         DCU2TXWAKiFLue9I74S4hzGPnRzecdwMmGtEmGTOBr1P9/cdDScSE92Jx6V+El2ghhdg
         D1CslKjUhqdsSRAlubpn+PVJaEm0rNEJyn1aMeOUBNKUJg5zZ5lQhgTB8uUSyZoI76w3
         AJRq2veWuFijaLnjKsilCQ2th8Fc15TrKDF8IYq3Cb1AcBa68SxhSx2QZhrdsyCYu+YQ
         5nlw==
X-Received: by 10.70.88.75 with SMTP id be11mr3798055pdb.140.1405951253031;
        Mon, 21 Jul 2014 07:00:53 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.246.202])
        by mx.google.com with ESMTPSA id o10sm19276367pdm.29.2014.07.21.07.00.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 07:00:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqy4vmakq3.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253967>



On 7/21/2014 7:15 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> On 7/21/2014 6:21 PM, Matthieu Moy wrote:
>>> 2) Add a by-address parameter to git_configset_get_value that allows the
>>>    user to get the file and line information. In your previous patch,
>>>    that would mean returning a pointer to the corresponding struct
>>>    key_source.
>>
>> Will this extra complexity be good for "git_configset_get_value"?
>> Instead can we provide a function like die_config(char *key)
>> which prints
>> 	die("bad config file line %d in %s", linenr, filename);?
> 
> Where would you call this function, and where would you take linenr and
> filename?
>

Usage can be like this,

if(!git_config_get_value(k, &v)) {
	if (!v) {
		config_error_nonbool(k);
		die_config(k);
		/* die_config calls git_config_get_value_multi for 'k',
		 * gets the string list with the util pointer containing
		 * the linenr and the file name, dies printing the message.
		 */
	} else
		/* do work */
}

Above example works just like the current code. Currently the callbacks
does not have the access to the linenr and file name anyway.
