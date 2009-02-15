From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sun, 15 Feb 2009 11:04:11 +0200
Message-ID: <94a0d4530902150104n555b845bofc5897230c64a5f2@mail.gmail.com>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
	 <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de>
	 <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com>
	 <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 10:06:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYcwi-0001LQ-Ib
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 10:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbZBOJES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 04:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbZBOJEQ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 04:04:16 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:2696 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbZBOJEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 04:04:13 -0500
Received: by fg-out-1718.google.com with SMTP id 16so106193fgg.17
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 01:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5lhaFEErjmZu6BKqvhQFVYtHiygQdktXATykSqHXuao=;
        b=ggBGBM7oC2NmgLQ4dqyl36ee8yk+bqLjlaICWiRK5edwOJ0Lt8jx/SHsLlhmlXHVOJ
         KZBL4U1lsMuMrPQz9dmg9W4P8Clss6IR0G9R4r1jyaCluRVJuEIlMDlYFBXSAmQLFw2k
         EUby73DDzFjJscACYFkPr6GnGe+7PiRfjWHG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rErkzBMc1jKEufXeLaxX5AyCrXN+6xA6eroioaEjT+muKKNJI+hIPd1pRFxoWjdxPK
         sCcKFh3wJv+Hba8LkTLtQuik3x5/Zpc5GoA4e3459vM+yMQBbJlfNozYs3pd3hnTVYKG
         PfqeIPiuYX9foFOhD3J/coVo9e8RlZ1iAfaPs=
Received: by 10.86.99.9 with SMTP id w9mr726659fgb.68.1234688651137; Sun, 15 
	Feb 2009 01:04:11 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109982>

On Sun, Feb 15, 2009 at 12:32 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 14 Feb 2009, Felipe Contreras wrote:
>
>> On Sat, Feb 14, 2009 at 9:59 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > On Sat, 14 Feb 2009, Felipe Contreras wrote:
>> >
>> >> @@ -231,7 +264,7 @@ static int get_diff_color_found;
>> >>  static int git_get_colorbool_config(const char *var, const char *value,
>> >>               void *cb)
>> >>  {
>> >> -     if (!strcmp(var, get_color_slot)) {
>> >> +     if (!strcmp(var, get_colorbool_slot)) {
>> >>               get_colorbool_found =
>> >>                       git_config_colorbool(var, value, stdout_is_tty);
>> >>       }
>> >
>> > Name changes like this make it harder to read the patch; can you separate
>> > that change out into its own patch?
>>
>> In that case I couldn't use OPT_STRING to store that value; I would
>> have to change --get-color* to use OPT_BOOLEAN or OPT_SET_INT and
>> store check the argc (since OPT_STRING isn't doing that anymore) and
>> save argv[1] to get_color_slot,
>
> What I meant was: have a patch renaming get_color_slot to
> get_colorbool_slot _before_ the (already large) parseoptification.

Done.

>> >> +                     die("unable to read config file %s: %s", file,
>> >> +                         strerror(errno));
>> >
>> > Do we really only want to die() in case we know the file name?  AFAICT at
>> > this point we have no idea in which of the possibly three files the error
>> > occurred.  And there need not be any errno set, for example when there was
>> > a parse error.
>>
>> Yes, there should be an error even if 'file' is not set. But if the
>> file is set what's wrong with that die command?
>
> I think we should die() in all cases, not just one, and we might want to
> skip the "file" parameter (and the "errno") parameter, as the file
> containing the error could be different from "file".

Done.

>> >> +     else if (actions & ACTION_EDIT) {
>> >> +             const char *config_filename;
>> >> +             if (config_exclusive_filename)
>> >> +                     config_filename = config_exclusive_filename;
>> >> +             else
>> >> +                     config_filename = git_path("config");
>> >
>> > Why not reuse config_exclusive_filename here?
>>
>> You mean:
>> if (!config_exclusive_filename)
>>   config_exclusive_filename = git_path("config");
>
> Yes.

I'm not sure about this one. At least git_config should be moved
before that code, otherwise it will only try to read core.editor from
the exclusive_filename and that's not what we want.

If somebody adds some extra code that uses config_exclusive_filename
there would be issues. I would prefer to leave it like that since
that's how the code in config.c is handling config_exclusive_filename.

>> >> +     else if (actions & ACTION_ADD) {
>> >> +             check_argc(argc, 2, 2);
>> >
>> > BTW what about check_argc() in the previous two cases?
>>
>> You mean fail if -e or -l have extra arguments?
>
> Yes.

Done.

>> >> +             return git_config_set_multivar(argv[0], value, "^$", 0);
>> >
>> > Now that I see this, there is another idea for a possible cleanup
>> > after the parseoptification: cmd_config() should not return -1, as
>> > that will be turned into the exit status.  So maybe prefix the return
>> > value with "!!"?
>> >
>> > Or maybe even better: set a variable "ret" and at the end of
>> > cmd_config(), "return !!ret;"?
>>
>> Huh? So git commands don't return negative error values?
>
> AFAICT an exit status is supposed to be between 0 and 127.

Ok. Done.

-- 
Felipe Contreras
